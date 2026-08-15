# header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO charlesnicholson/nanoprintf
    REF "v${VERSION}"
    SHA512 69deaf564669ed0b61a97ee6c669b754b179de4a6d49e67ac12f1c309c945a0f76309c9ee4cc2698f384e567345be789b3735ed7e16acc6dc13eed5567ca7011
    HEAD_REF master
)

vcpkg_download_distfile(NANOPRINTF_HEADER
    URLS "https://github.com/charlesnicholson/nanoprintf/releases/download/v${VERSION}/nanoprintf.h"
    FILENAME "nanoprintf-${VERSION}.h"
    SHA512 8e461c4fa607feb6379b9dc2ac5c156baecb57d62ad7f4fa0bc9ba1773bc44f9c373bd1091ac19de024a6dd600fa9679028b1a8ec2536bf0c9881ac211dfaa3a
)

file(INSTALL "${NANOPRINTF_HEADER}" DESTINATION "${CURRENT_PACKAGES_DIR}/include" RENAME "nanoprintf.h")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
