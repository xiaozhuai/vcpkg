set(VCPKG_BUILD_TYPE release) # configure_file only

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/glesx-config.cmake" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
vcpkg_cmake_config_fixup()

if (VCPKG_TARGET_IS_EMSCRIPTEN)
    set(GLESX_PKGCONFIG_EGL_LIBS "-sUSE_WEBGL2=1 -sFULL_ES3=1")
    set(GLESX_PKGCONFIG_GLESV2_LIBS "-sUSE_WEBGL2=1 -sFULL_ES3=1")
elseif (VCPKG_TARGET_IS_ANDROID)
    set(GLESX_PKGCONFIG_EGL_LIBS "-lEGL")
    set(GLESX_PKGCONFIG_GLESV2_LIBS "-lGLESv3")
elseif (VCPKG_TARGET_IS_LINUX)
    set(GLESX_PKGCONFIG_EGL_LIBS "-lEGL")
    set(GLESX_PKGCONFIG_GLESV2_LIBS "-lGLESv2")
elseif (VCPKG_TARGET_IS_WINDOWS OR VCPKG_TARGET_IS_IOS OR VCPKG_TARGET_IS_OSX)
    set(GLESX_PKGCONFIG_EGL_LIBS "-lEGL")
    set(GLESX_PKGCONFIG_GLESV2_LIBS "-lGLESv2")
else()
    message(FATAL_ERROR "glesx package is not available for ${VCPKG_CMAKE_SYSTEM_NAME}")
endif()

configure_file("${CMAKE_CURRENT_LIST_DIR}/glesx-egl.pc.in" "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/glesx-egl.pc" @ONLY)
configure_file("${CMAKE_CURRENT_LIST_DIR}/glesx-egl.pc.in" "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/glesx-egl.pc" @ONLY)

configure_file("${CMAKE_CURRENT_LIST_DIR}/glesx-glesv2.pc.in" "${CURRENT_PACKAGES_DIR}/lib/pkgconfig/glesx-glesv2.pc" @ONLY)
configure_file("${CMAKE_CURRENT_LIST_DIR}/glesx-glesv2.pc.in" "${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig/glesx-glesv2.pc" @ONLY)

vcpkg_fixup_pkgconfig()

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")

set(VCPKG_POLICY_EMPTY_PACKAGE enabled)
