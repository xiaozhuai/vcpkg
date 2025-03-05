vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xiaozhuai/xiaozhuai-angle
    REF e5188eecd8b7ffdc68f19d07726a8cede0f0f171
    SHA512 bf2e99911c99ab353a668a56bd26f32ecf041d32406f8cd5aa6300ca61b01ec0fee0455dbf3ceaa6e0f8ed28d5575496fecfe412deeeedadee5c2c7c31062642
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
