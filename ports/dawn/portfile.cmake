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

# vcpkg_find_acquire_program(PYTHON3)
# vcpkg_execute_in_download_mode(
#     COMMAND "${PYTHON3}" tools/fetch_dawn_dependencies.py
#     WORKING_DIRECTORY "${SOURCE_PATH}"
# )

function(checkout_in_path PATH URL REF)
    if(EXISTS "${PATH}")
        file(GLOB_RECURSE subdirectory_children "${CURRENT_PACKAGES_DIR}/include/${directory_child}/*")
        if(NOT "${subdirectory_children}" STREQUAL "")
            return()
        endif()
    endif()

    vcpkg_from_git(
        OUT_SOURCE_PATH DEP_SOURCE_PATH
        URL "${URL}"
        REF "${REF}"
    )
    file(RENAME "${DEP_SOURCE_PATH}" "${PATH}")
    file(REMOVE_RECURSE "${DEP_SOURCE_PATH}")
endfunction()

checkout_in_path(
    "${SOURCE_PATH}/third_party/abseil-cpp"
    "https://chromium.googlesource.com/chromium/src/third_party/abseil-cpp"
    "f81f6c011baf9b0132a5594c034fe0060820711d"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/dxc"
    "https://chromium.googlesource.com/external/github.com/microsoft/DirectXShaderCompiler"
    "20950d662f4d24850d7edfe1e647f6749d5c13b3"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/dxheaders"
    "https://chromium.googlesource.com/external/github.com/microsoft/DirectX-Headers"
    "980971e835876dc0cde415e8f9bc646e64667bf7"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/glfw"
    "https://chromium.googlesource.com/external/github.com/glfw/glfw"
    "b35641f4a3c62aa86a0b3c983d163bc0fe36026d"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/jinja2"
    "https://chromium.googlesource.com/chromium/src/third_party/jinja2"
    "e2d024354e11cc6b041b0cff032d73f0c7e43a07"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/khronos/EGL-Registry"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/EGL-Registry"
    "7dea2ed79187cd13f76183c4b9100159b9e3e071"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/khronos/OpenGL-Registry"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/OpenGL-Registry"
    "5bae8738b23d06968e7c3a41308568120943ae77"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/libprotobuf-mutator/src"
    "https://chromium.googlesource.com/external/github.com/google/libprotobuf-mutator.git"
    "a304ec48dcf15d942607032151f7e9ee504b5dcf"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/protobuf"
    "https://chromium.googlesource.com/chromium/src/third_party/protobuf"
    "da2fe725b80ac0ba646fbf77d0ce5b4ac236f823"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/markupsafe"
    "https://chromium.googlesource.com/chromium/src/third_party/markupsafe"
    "0bad08bb207bbfc1d6f3bbc82b9242b0c50e5794"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/glslang/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/glslang"
    "00ac5651f528d84cc3cf7320b34407bce7d38d93"
)

# checkout_in_path(
#     "${SOURCE_PATH}/third_party/google_benchmark/src"
#     "https://chromium.googlesource.com/external/github.com/google/benchmark.git"
#     "761305ec3b33abf30e08d50eb829e19a802581cc"
# )

# checkout_in_path(
#     "${SOURCE_PATH}/third_party/googletest"
#     "https://chromium.googlesource.com/external/github.com/google/googletest"
#     "7a7231c442484be389fdf01594310349ca0e42a8"
# )

checkout_in_path(
    "${SOURCE_PATH}/third_party/spirv-headers/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/SPIRV-Headers"
    "09913f088a1197aba4aefd300a876b2ebbaa3391"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/spirv-tools/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/SPIRV-Tools"
    "dc1641d168304d3ef97bba23d5fc45c9bead45f5"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-headers/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Headers"
    "234c4b7370a8ea3239a214c9e871e4b17c89f4ab"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-loader/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Loader"
    "fde0f9718bd60b49cf8efc80d3fb7a093c309ac0"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-utility-libraries/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Utility-Libraries"
    "fe7a09b13899c5c77d956fa310286f7a7eb2c4ed"
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DDAWN_ENABLE_INSTALL=ON
        -DDAWN_USE_GLFW=OFF
        -DDAWN_BUILD_SAMPLES=OFF
        -DTINT_BUILD_GLSL_WRITER=ON
        -DTINT_BUILD_TESTS=OFF
        -DTINT_ENABLE_INSTALL=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/Dawn)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
