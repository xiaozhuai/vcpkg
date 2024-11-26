vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/dawn
    REF 48886872a28bae958e1f9cd5b85de52b6cabcf23 # chromium_7285
    SHA512 8a2f6643e02bc0a0ae7e94f7471e6a021fc960e3a79649378b3ab9fb839b6b31b551a9edfe137827dc8805de14e2197b05efd6beda7ff1581824d2bb66e4281c
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
    "04dc59d2c83238cb1fcb49083e5e416643a899ce"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/dxc"
    "https://chromium.googlesource.com/external/github.com/microsoft/DirectXShaderCompiler"
    "2da0a54f150f51bd6a2b85fd4cc76bdfd614219e"
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
    "7bf98f78a30b067e22420ff699348f084f802e12"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/protobuf"
    "https://chromium.googlesource.com/chromium/src/third_party/protobuf"
    "1a4051088b71355d44591172c474304331aaddad"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/markupsafe"
    "https://chromium.googlesource.com/chromium/src/third_party/markupsafe"
    "0bad08bb207bbfc1d6f3bbc82b9242b0c50e5794"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/glslang/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/glslang"
    "8a85691a0740d390761a1008b4696f57facd02c4"
)

# checkout_in_path(
#     "${SOURCE_PATH}/third_party/google_benchmark/src"
#     "https://chromium.googlesource.com/external/github.com/google/benchmark.git"
#     "761305ec3b33abf30e08d50eb829e19a802581cc"
# )

# checkout_in_path(
#     "${SOURCE_PATH}/third_party/googletest"
#     "https://chromium.googlesource.com/external/github.com/google/googletest"
#     "52204f78f94d7512df1f0f3bea1d47437a2c3a58"
# )

checkout_in_path(
    "${SOURCE_PATH}/third_party/spirv-headers/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/SPIRV-Headers"
    "1de2e410ae8b5f7276afcfd9f3401a1c4e2cb2d7"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/spirv-tools/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/SPIRV-Tools"
    "44c93ad924b647b0d803ef4c924251c4341b838b"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-headers/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Headers"
    "16cedde3564629c43808401ad1eb3ca6ef24709a"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-loader/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Loader"
    "8beef6cb63ffadb02300bf6321b4d3af85ea7417"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-utility-libraries/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Utility-Libraries"
    "f3cfb7fa8994e37c7c0568e33a785591af2ca696"
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
