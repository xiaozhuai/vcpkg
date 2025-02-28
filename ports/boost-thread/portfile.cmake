# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/thread
    REF boost-${VERSION}
    SHA512 0c10698176e695011b70aea5b0f427bb4265032349297fd6d71cb8b4d82ff4144ce8b5a4bc7ed9587485e51e46764820d3d4688a1e576dd8ec375140bce1f708
    HEAD_REF master
)

set(FEATURE_OPTIONS "")
boost_configure_and_install(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS ${FEATURE_OPTIONS}
)
