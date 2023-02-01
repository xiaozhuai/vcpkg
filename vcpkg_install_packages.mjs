$.verbose = true;

if (process.platform === 'win32') {
    $.shell = 'cmd';
    $.prefix = '';
    $.quote = function (str) {
        return `"${str}"`;
    };
}

async function vcpkg_bootstrap() {
    if (process.platform === 'win32') {
        await $`.\\bootstrap-vcpkg.bat`;
    } else {
        await $`./bootstrap-vcpkg.sh`;
    }
}

async function vcpkg_install(ports, triplets) {
    const options = [
        '--clean-buildtrees-after-build',
        '--clean-packages-after-build',
        '--no-print-usage'
    ];
    let list = [];
    for (const port of ports) {
        for (const triplet of triplets) {
            list.push(`${port}:${triplet}`);
        }
    }
    if (process.platform === 'win32') {
        return (await $`.\\vcpkg install ${list} ${options}`).stdout;
    } else {
        return (await $`./vcpkg install ${list} ${options}`).stdout;
    }
}

async function generateSummaryFile(stdout, summaryFile, title) {
    const output = String(stdout).replace(/\r\n/g, "\n");

    const planMatch = output.match(
        /The following packages will be built and installed:\n([\s\S]*?)Detecting compiler hash/
    );

    if (!planMatch) {
        throw new Error("Could not find the vcpkg installation plan");
    }

    function parsePackageSpec(fullSpec) {
        const match = fullSpec.match(
            /^([^:[\s]+)(?:\[([^\]]*)])?:([^@\s]+)@(.+)$/
        );

        if (!match) {
            return null;
        }

        const name = match[1];

        let features = match[2] ?? '';
        features = features.split(',').filter(f => f !== 'core' && f !== '');
        features = ['core', ...features];

        const triplet = match[3];
        const version = match[4];

        return {
            fullSpec,
            name,
            features,
            triplet,
            version,
        };
    }

    const packages = [];
    const packageMap = {};

    for (const line of planMatch[1].split("\n")) {
        const match = line.match(/^\s*(\*)?\s+(.+?:[^@\s]+@.+?)\s*$/);

        if (!match) {
            continue;
        }

        const fullSpec = match[2];
        const spec = parsePackageSpec(fullSpec);

        if (!spec) {
            continue;
        }

        const packageInfo = {
            ...spec,
            indirect: Boolean(match[1]),
            cacheHit: null,
            elapsed: null,
        };

        packages.push(packageInfo);
        packageMap[fullSpec] = packageInfo;
    }

    const installRegex = /^Installing\s+\d+\/\d+\s+(.+?)\.\.\.\s*$/gm;
    const installMatches = [...output.matchAll(installRegex)];

    for (let i = 0; i < installMatches.length; ++i) {
        const current = installMatches[i];
        const blockStart = current.index;
        const blockEnd =
            i + 1 < installMatches.length
                ? installMatches[i + 1].index
                : output.length;

        const installedFullSpec = current[1];
        const packageInfo = packageMap[installedFullSpec];
        if (!packageInfo) {
            continue;
        }

        const block = output.slice(blockStart, blockEnd);

        // 出现 Building 表示 binary cache 未命中。
        packageInfo.cacheHit = !/^Building\s+.+?\.\.\.\s*$/m.test(block);

        const elapsedMatch = block.match(
            /^Elapsed time to handle\s+.+?:\s+(.+?)\s*$/m
        );

        if (elapsedMatch) {
            packageInfo.elapsed = elapsedMatch[1];
        }
    }

    const cacheHits = packages.filter(item => item.cacheHit === true).length;
    const cacheMisses = packages.filter(item => item.cacheHit === false).length;

    function escapeMarkdown(value) {
        return String(value)
            .replaceAll("\\", "\\\\")
            .replaceAll("|", "\\|")
            .replaceAll("`", "\\`");
    }

    const lines = [];

    if (title) {
        lines.push(
            `## ${title}`,
            ``
        );
    }

    lines.push(
        `* Packages: ${packages.length}`,
        `* Binary cache hits: ${cacheHits}`,
        `* Binary cache misses: ${cacheMisses}`
    );    

    lines.push(
        "<details>",
        "",
        "<summary>Details</summary>",
        "",
        "| * | Name | Features | Triplet | Version | Cache | Time |",
        "| :---: | --- | --- | --- | --- | :---: | ---: |"
    );

    packages.sort((a, b) => {
        const tripletResult = a.triplet.localeCompare(b.triplet);

        if (tripletResult !== 0) {
            return tripletResult;
        }

        return a.name.localeCompare(b.name);
    });

    for (const packageInfo of packages) {
        lines.push(
            `| ${packageInfo.indirect ? "*" : ""} ` +
            `| \`${escapeMarkdown(packageInfo.name)}\` ` +
            `| \`${escapeMarkdown(packageInfo.features.join(','))}\`` +
            `| \`${escapeMarkdown(packageInfo.triplet)}\` ` +
            `| \`${escapeMarkdown(packageInfo.version)}\` ` +
            `| ${packageInfo.cacheHit ? '✅' : '❌'} ` +
            `| ${packageInfo.elapsed ?? "N/A"} |`
        );
    }

    lines.push(
        "",
        "</details>",
    );

    await fs.appendFile(summaryFile, lines.join("\n"), "utf8");
}

// console.log(argv);

const platforms = argv._;
if (platforms.length === 0) {
    throw new Error('No file specified');
}
for (const platform of platforms) {
    const file = path.join(__dirname, 'zzz_global_ports', `${platform}.yml`);
    if (!(await fs.pathExists(file))) {
        throw new Error(`File not found: ${file}`);
    }
}

if (argv.clean) {
    const dirs = [
        'buildtrees',
        'installed',
        'packages',
    ];
    for (const dir of dirs) {
        await fs.emptyDir(path.join(__dirname, dir));
    }
}

if (argv['clean-downloads']) {
    await fs.emptyDir(path.join(__dirname, 'downloads'));
}

const summaryFile = process.env.GITHUB_STEP_SUMMARY ?? process.env.GITEA_STEP_SUMMARY;

await vcpkg_bootstrap();

for (const platform of platforms) {
    const file = path.join(__dirname, 'zzz_global_ports', `${platform}.yml`);
    if (!(await fs.pathExists(file))) {
        throw new Error(`File not found: ${file}`);
    }
    const { env, ports, triplets } = YAML.parse(await fs.readFile(file, 'utf8'));
    if (env) {
        for (const key in env) {
            $.env[key] = env[key];
        }
    }
    const stdout = await vcpkg_install(ports, triplets);
    if (summaryFile) {
        await generateSummaryFile(stdout, summaryFile, platforms.length > 1 ? platform : '');
    }
}

{
    const dirs = [
        'buildtrees',
        'packages',
    ];
    for (const dir of dirs) {
        await fs.emptyDir(path.join(__dirname, dir));
    }
}
