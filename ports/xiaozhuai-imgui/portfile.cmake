vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xiaozhuai/xiaozhuai-imgui
    REF 713ed42e21560bba6b2b4c2ead50f0acf2655dab
    SHA512 a973454a8e9858d96f55786e9e7968a46559c9a385a6c9febedc51e12b77072e6f4d43f9d6eeb020237c1a6f8a2a30b9d216ac93d4430e603202c9a37cd77f6e
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        gles3 IMGUI_BACKEND_GLES3
        glfw IMGUI_BACKEND_GLFW
        android IMGUI_BACKEND_ANDROID
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME imgui)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
