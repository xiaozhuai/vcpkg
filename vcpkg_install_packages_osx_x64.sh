#!/usr/bin/env bash

vcpkg_install() {
    pkg="$1"
    ./vcpkg install                                 \
        --clean-buildtrees-after-build              \
        --clean-packages-after-build                \
        --no-print-usage                            \
        ${pkg}:x64-osx
}

./bootstrap-vcpkg.sh

vcpkg_install pkgconf

vcpkg_install cmakerc

vcpkg_install fmt

vcpkg_install spdlog

# vcpkg_install wasmedge

vcpkg_install palsigslot

vcpkg_install nanobench

vcpkg_install imageinfo

vcpkg_install nameof

vcpkg_install uvw

vcpkg_install xorstr

vcpkg_install xxhash

vcpkg_install wyhash

vcpkg_install minifb

vcpkg_install string-view-lite

vcpkg_install ghc-filesystem

vcpkg_install stb

vcpkg_install glm

vcpkg_install protobuf

vcpkg_install nlohmann-json

vcpkg_install inja

vcpkg_install leveldb

vcpkg_install neon2sse

vcpkg_install highway

vcpkg_install tbb

vcpkg_install luajit

vcpkg_install luabridge

vcpkg_install duktape

vcpkg_install yoga

vcpkg_install libwebp

vcpkg_install libimobiledevice

vcpkg_install libusb

vcpkg_install libyuv

vcpkg_install angle

vcpkg_install glesx

vcpkg_install glfw3-link-egl

vcpkg_install imgui-glfw-es3

vcpkg_install vulkan-headers

vcpkg_install skia

vcpkg_install cairo

vcpkg_install cairomm

vcpkg_install ffmpeg

vcpkg_install opencv

vcpkg_install qt5
