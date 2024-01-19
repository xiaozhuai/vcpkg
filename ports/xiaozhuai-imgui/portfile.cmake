vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ocornut/imgui
    REF 643f0e3abf6f84c210ea717f62c02bf411fc2e8c
    SHA512 1d3fd82bf381db753f764f43c7a2c2cfc59f44a3abbdcaa3c7eeeed49211eb27cc6f784211c9dd4203b54b4b85dc849516ee142254a6c627a3dc1a4f58f28879
    HEAD_REF master
    PATCHES
        use_opengl_es3.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/imgui-config.cmake.in" DESTINATION "${SOURCE_PATH}")

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
