#!/usr/bin/env bash

export ANDROID_NDK_HOME="${ANDROID_HOME}/ndk/26.3.11579264"

vcpkg_install() {
    pkg="$1"
    ./vcpkg install                                 \
        --clean-buildtrees-after-build              \
        --clean-packages-after-build                \
        --no-print-usage                            \
        ${pkg}:arm64-android                        \
        ${pkg}:arm-neon-android                     \
        ${pkg}:x64-android
}

./bootstrap-vcpkg.sh

vcpkg_install cmakerc

vcpkg_install nanobench

vcpkg_install nlohmann-json

vcpkg_install inja

vcpkg_install fmt

vcpkg_install spdlog

vcpkg_install nameof

vcpkg_install xorstr

vcpkg_install xxhash

vcpkg_install wyhash

vcpkg_install stb

vcpkg_install neon2sse

vcpkg_install highway

vcpkg_install glm

vcpkg_install duktape

vcpkg_install libyuv

vcpkg_install glesx
