vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO google/dawn
    REF 096e0f9a56820b5e57cf7f5e388b3dafb8231f31 # chromium_7139
    SHA512 5d77fdea7e231951ca84464dadd2d97600c9371cc976e0c5b7a12e426485775c8c63adc99739276b7f9a650220e0d03d25e97064996194c02f6f7ab8d68ab35c
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

vcpkg_apply_patches(
    SOURCE_PATH "${SOURCE_PATH}/third_party/abseil-cpp"
    PATCHES 
        "fix_abseil.patch"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/dxc"
    "https://chromium.googlesource.com/external/github.com/microsoft/DirectXShaderCompiler"
    "b93f6a46fd78fe5557f7a5263d8f4885ea3930fd"
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
    "fd4339381023e29132ed8133af9a2b388c248a09"
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
    "aa6cef192b8e693916eb713e7a9ccadf06062ceb"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/spirv-tools/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/SPIRV-Tools"
    "ca63ea568b41d461dd25fa588350008b5ab00c89"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-headers/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Headers"
    "409c16be502e39fe70dd6fe2d9ad4842ef2c9a53"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-loader/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Loader"
    "fb78607414e154c7a5c01b23177ba719c8a44909"
)

checkout_in_path(
    "${SOURCE_PATH}/third_party/vulkan-utility-libraries/src"
    "https://chromium.googlesource.com/external/github.com/KhronosGroup/Vulkan-Utility-Libraries"
    "4e246c56ec5afb5ad66b9b04374d39ac04675c8e"
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
