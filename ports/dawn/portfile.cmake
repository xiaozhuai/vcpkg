# chromium/7017
set(DAWN_VERSION 7017)
set(DAWN_COMMIT c820ca753de0b0cb90582f7e843bf24c2be744e2)
set(DAWN_SHA512 c11cf03ae10afe0a7c9f0db3facbcfcd2b0a048736b107afe35e336510deba6339def6e6e7d9754bcf90883eda6368af20ff83c0cf6f3fa3eecd73c2b2c4d0d7)

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
