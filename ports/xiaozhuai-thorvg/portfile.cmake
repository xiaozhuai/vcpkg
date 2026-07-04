vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO thorvg/thorvg
    REF "v${VERSION}"
    SHA512 0b4489bf589196b23f04396929ffe0523a013f42a799c8c2018ea9784bda4044d6b843b8bb4c677f997e99b52f44e1fb2847672ec6659edb9ae89132396f57b2
    HEAD_REF master
    PATCHES
        001-link-opengles.patch
)

if ("tools" IN_LIST FEATURES)
    list(APPEND BUILD_OPTIONS -Dtools=all)
endif()

vcpkg_configure_meson(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${BUILD_OPTIONS}
        # see ${SOURCE_PATH}/meson_options.txt
        -Dstatic=true # Use static modules
        -Dengines=['cpu','gl']
        -Dloaders=all
        -Dsavers=all
        -Dsimd=true
        -Dbindings=capi
        -Dtests=false
        -Dstrip=false
        -Dextra=['opengl_es']
    OPTIONS_DEBUG
        -Dlog=false
        -Dbindir=${CURRENT_PACKAGES_DIR}/debug/bin
    OPTIONS_RELEASE
        -Dbindir=${CURRENT_PACKAGES_DIR}/bin
)
vcpkg_install_meson()
vcpkg_fixup_pkgconfig()

if(VCPKG_LIBRARY_LINKAGE STREQUAL "static")
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/thorvg-1/thorvg.h" "#ifndef TVG_STATIC" "#if 0")
else()
    vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/include/thorvg-1/thorvg.h" "#ifndef TVG_STATIC" "#if 1")
endif()

if ("tools" IN_LIST FEATURES)
    vcpkg_copy_tools(TOOL_NAMES tvg-svg2png tvg-lottie2gif AUTO_CLEAN)
endif()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
