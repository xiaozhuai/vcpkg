vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xiaozhuai/imgui_glfw_es3
    REF 50bba161105e278acf3968c9a754c6a05906ac22
    SHA512 a2e4c7f8189bd7608260c5e9ef6c81a2925ec1175fd18c43ed5c39c26baefb714d1fa6be9f11a988fad44e14aea86bccd44012235030dc5aff7127b9346dba5a
    HEAD_REF master
)

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        gles3 IMGUI_BACKEND_GLES3
        glfw IMGUI_BACKEND_GLFW
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
