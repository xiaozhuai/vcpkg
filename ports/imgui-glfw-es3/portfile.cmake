vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xiaozhuai/imgui_glfw_es3
    REF 91c7ec99295eced7dc40e1ba7ef6e9c2e23d75e3
    SHA512 6e4de85dec8255d6a2ff5dcab664cfe5ce42baa63e4e315975f700f7fe7cc400011670bc50d968ed274ed39ed9547377a5b7c0515df73b9a30cc62218ab0f100
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME imgui)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")
