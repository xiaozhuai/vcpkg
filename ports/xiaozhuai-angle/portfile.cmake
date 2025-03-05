vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xiaozhuai/xiaozhuai-angle
    REF 1880b3811cb7ca198247eff2d7ea8a0fcb438b2e
    SHA512 bbc6c9b2ae26f935c61f1d0fbec27d28c0a5f122c55e27d3b19c812c14e06c3cd42d84d441c1a6b9b1d40aa23002316f639015a7b889dd0a6b76883a0485401c
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DANGLE_BUILD_INSTALL=ON
        -DANGLE_EXCLUDE_REGISTRY_HEADERS=ON
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME unofficial-angle)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
# Remove empty directories inside include directory
file(GLOB directory_children RELATIVE "${CURRENT_PACKAGES_DIR}/include" "${CURRENT_PACKAGES_DIR}/include/*")
foreach(directory_child ${directory_children})
    if(IS_DIRECTORY "${CURRENT_PACKAGES_DIR}/include/${directory_child}")
        file(GLOB_RECURSE subdirectory_children "${CURRENT_PACKAGES_DIR}/include/${directory_child}/*")
        if("${subdirectory_children}" STREQUAL "")
            file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/include/${directory_child}")
        endif()
    endif()
endforeach()

set(VCPKG_POLICY_DLLS_IN_STATIC_LIBRARY enabled)
set(VCPKG_POLICY_SKIP_COPYRIGHT_CHECK enabled)
set(VCPKG_FIXUP_MACHO_RPATH OFF)
