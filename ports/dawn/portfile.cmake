# chromium/6859
set(DAWN_VERSION 6859)
set(DAWN_COMMIT 91bcd47a30c2e70f737cad19ceff2fc7adf3a61e)
set(DAWN_SHA512 fc7539949a7a0b12e7dc12add1712bd6628b63efe92c28663c99b5f2c26b58fdf7d9a05a8de7b42839682e175a305f66134d09a987e14f4c853443125d3a2e68)

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
