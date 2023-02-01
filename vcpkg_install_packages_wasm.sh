#!/usr/bin/env bash

vcpkg_install() {
    pkg="$1"
    ./vcpkg install                                 \
        --clean-buildtrees-after-build              \
        --clean-packages-after-build                \
        --no-print-usage                            \
        ${pkg}:wasm32-emscripten
}

./bootstrap-vcpkg.sh

vcpkg_install cmakerc

vcpkg_install fmt

vcpkg_install spdlog

vcpkg_install xxhash

vcpkg_install wyhash

vcpkg_install stb

vcpkg_install neon2sse

vcpkg_install highway

vcpkg_install glm

vcpkg_install libwebp

vcpkg_install duktape

# vcpkg_install libyuv

vcpkg_install glesx

vcpkg_install glfw3-link-egl

vcpkg_install imgui-glfw-es3
