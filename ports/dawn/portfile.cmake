# chromium/6889
set(DAWN_VERSION 6889)
set(DAWN_COMMIT 61f029ad73e4cb0bf986b37731d22b8b20a04498)
set(DAWN_SHA512 820da795867752943cdfb1a02ebbcda54f7c0f0c09554ef6cf7db4b080e58ed6d0cb4971dbdf8edbe6e573453540fef6c6a7edc2d571b81294f7912c2ded580a)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/dawn
    REF ${DAWN_COMMIT}
    SHA512 ${DAWN_SHA512}
    HEAD_REF master
)

vcpkg_find_acquire_program(PYTHON3)
vcpkg_execute_in_download_mode(
    COMMAND "${PYTHON3}" tools/fetch_dawn_dependencies.py
    WORKING_DIRECTORY "${SOURCE_PATH}"
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DDAWN_ENABLE_INSTALL=ON
        -DDAWN_USE_GLFW=OFF # It's not a dependency of Dawn, but it's used in the samples
        -DDAWN_BUILD_SAMPLES=OFF
        -DTINT_BUILD_GLSL_WRITER=ON
        -DTINT_BUILD_TESTS=OFF
        -DTINT_ENABLE_INSTALL=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/Dawn)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
