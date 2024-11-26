# chromium/6905
set(DAWN_VERSION 6905)
set(DAWN_COMMIT c590dc8722adfb03f53556d4b24d8972134fd289)
set(DAWN_SHA512 61f99f22b4999eb41cc7310dde6408bcf573527b7ebcfc4e431571a55c2bb763ff72e29cbfdbdb78f3f30348152abdba6245642fdb9236bc6912359d62945c86)

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
