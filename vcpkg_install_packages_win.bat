@echo off

if "%parent%"=="" set parent=%~0
if "%console_mode%"=="" (set console_mode=1& for %%x in (%cmdcmdline%) do if /i "%%~x"=="/c" set console_mode=0)

SETLOCAL

rem ------------------------------------------

call bootstrap-vcpkg.bat

call :vcpkg_install_x64 pkgconf

call :vcpkg_install_x64 cmakerc
call :vcpkg_install_x86 cmakerc

call :vcpkg_install_x64 fmt

call :vcpkg_install_x64 spdlog

rem call :vcpkg_install_x64 wasmedge

call :vcpkg_install_x64 palsigslot

call :vcpkg_install_x64 nanobench

call :vcpkg_install_x64 imageinfo

call :vcpkg_install_x64 nameof

call :vcpkg_install_x64 uvw

call :vcpkg_install_x64 xorstr

call :vcpkg_install_x64 xxhash

call :vcpkg_install_x64 wyhash

call :vcpkg_install_x64 minifb

call :vcpkg_install_x64 string-view-lite

call :vcpkg_install_x64 ghc-filesystem

call :vcpkg_install_x64 stb

call :vcpkg_install_x64 glm

call :vcpkg_install_x64 protobuf

call :vcpkg_install_x64 nlohmann-json

call :vcpkg_install_x64 inja

call :vcpkg_install_x64 leveldb

call :vcpkg_install_x64 neon2sse

call :vcpkg_install_x86 neon2sse

call :vcpkg_install_x64 highway

call :vcpkg_install_x86 highway

call :vcpkg_install_x64 tbb

call :vcpkg_install_x64 luajit

call :vcpkg_install_x64 luabridge

call :vcpkg_install_x64 duktape

call :vcpkg_install_x64 yoga

call :vcpkg_install_x64 libwebp

call :vcpkg_install_x64 libimobiledevice

call :vcpkg_install_x64 libusb

call :vcpkg_install_x64 libyuv
call :vcpkg_install_x86 libyuv

call :vcpkg_install_x64 angle

call :vcpkg_install_x64 glesx

call :vcpkg_install_x64 glfw3-link-egl

call :vcpkg_install_x64 imgui-glfw-es3

call :vcpkg_install_x64 vulkan-headers

call :vcpkg_install_x64 skia

call :vcpkg_install_x64 cairo

call :vcpkg_install_x64 cairomm

call :vcpkg_install_x64 ffmpeg

call :vcpkg_install_x64 opencv
call :vcpkg_install_x86 opencv

call :vcpkg_install_x64 qt5


if "%parent%"=="%~0" ( if "%console_mode%"=="0" pause )

EXIT /B %ERRORLEVEL%

rem ------------------------------------------

:vcpkg_install_x64
.\vcpkg.exe install --clean-buildtrees-after-build --clean-packages-after-build --no-print-usage %~1:x64-windows
EXIT /B 0

rem ------------------------------------------

:vcpkg_install_x86
.\vcpkg.exe install --clean-buildtrees-after-build --clean-packages-after-build --no-print-usage %~1:x86-windows
EXIT /B 0
