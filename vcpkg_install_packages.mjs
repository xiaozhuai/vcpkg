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
        await $`.\\vcpkg install ${list} ${options}`;
    } else {
        await $`./vcpkg install ${list} ${options}`;
    }
}

// console.log(argv);

const files = argv._;
if (files.length === 0) {
    throw new Error('No file specified');
}
for (let file of files) {
    file = path.join(__dirname, 'zzz_global_ports', `${file}.yml`);
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

await vcpkg_bootstrap();

for (let file of files) {
    file = path.join(__dirname, 'zzz_global_ports', `${file}.yml`);
    if (!(await fs.pathExists(file))) {
        throw new Error(`File not found: ${file}`);
    }
    const { env, ports, triplets } = YAML.parse(await fs.readFile(file, 'utf8'));
    if (env) {
        for (const key in env) {
            $.env[key] = env[key];
        }
    }
    await vcpkg_install(ports, triplets);
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
