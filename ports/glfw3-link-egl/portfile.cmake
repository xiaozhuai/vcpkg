if (VCPKG_TARGET_IS_EMSCRIPTEN)
    # emscripten has built-in glfw3 library
    set(VCPKG_BUILD_TYPE release)
    file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/glfw3Config.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/glfw3")
    set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
    return()
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xiaozhuai/glfw_link_egl
    REF d97e0e019e6038c0c59ade0d4776c185d736ed0f
    SHA512 4c132edbdaaba22029dff8490cf009f832b357bc5fad89da3b534ca3b65a27e502a50440fa1bef357b7effdf1dd3feca15855c0dee7cdd08a37bab702dafc2a3
    HEAD_REF master
)

if(VCPKG_TARGET_IS_LINUX)
    message(
"GLFW3 currently requires the following libraries from the system package manager:
    xinerama
    xcursor
    xorg
    libglu1-mesa
    pkg-config

These can be installed on Ubuntu systems via sudo apt install libxinerama-dev libxcursor-dev xorg-dev libglu1-mesa-dev pkg-config

Alternatively, when targeting the Wayland display server, use the packages listed in the GLFW documentation here:

https://www.glfw.org/docs/3.3/compile.html#compile_deps_wayland")
endif()

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
    wayland         GLFW_USE_WAYLAND
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DGLFW_BUILD_EXAMPLES=OFF
        -DGLFW_BUILD_TESTS=OFF
        -DGLFW_BUILD_DOCS=OFF
        -DGLFW_LINK_LIBEGL=ON
        -DGLFW_USE_GLESX=ON
        ${FEATURE_OPTIONS}
    MAYBE_UNUSED_VARIABLES
        GLFW_USE_WAYLAND
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME glfw3
    CONFIG_PATH lib/cmake/glfw3
)

vcpkg_fixup_pkgconfig()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.md")
