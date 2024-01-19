vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ocornut/imgui
    REF ba84d2d37253c89b17b2cb7b357e130093b79ef5
    SHA512 0e6d430644f9812867f852b84b7999c73268f08b2af300ed649d50c1475c8f70a612ae1084a3eca82eed0b0d404e0160106ac638b1b6718f4f67f5bf1d1334ed
    HEAD_REF master
    PATCHES
        use_opengl_es3.patch
        use_wgpu_dawn.patch
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION "${SOURCE_PATH}")
file(COPY "${CMAKE_CURRENT_LIST_DIR}/imgui-config.cmake.in" DESTINATION "${SOURCE_PATH}")

vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        android IMGUI_BACKEND_ANDROID
        gles3 IMGUI_BACKEND_GLES3
        glfw IMGUI_BACKEND_GLFW
        wgpu IMGUI_BACKEND_WGPU
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
