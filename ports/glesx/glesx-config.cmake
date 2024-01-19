include(CMakeFindDependencyMacro)

if (NOT TARGET glesx::EGL)
    add_library(glesx::EGL INTERFACE IMPORTED)
    if (EMSCRIPTEN)
        set_target_properties(glesx::EGL PROPERTIES
            INTERFACE_LINK_OPTIONS "-sUSE_WEBGL2=1 -sFULL_ES3=1"
        )
    elseif (ANDROID)
        set_target_properties(glesx::EGL PROPERTIES
            INTERFACE_LINK_LIBRARIES "EGL"
        )
    elseif (UNIX AND NOT APPLE)
        set_target_properties(glesx::EGL PROPERTIES
            INTERFACE_LINK_LIBRARIES "EGL"
        )
    elseif (WIN32 OR IOS OR APPLE)
        find_dependency(unofficial-angle REQUIRED)
        set_target_properties(glesx::EGL PROPERTIES
            INTERFACE_LINK_LIBRARIES "unofficial::angle::libEGL"
        )
    else()
        message(FATAL_ERROR "glesx::EGL target is not available for ${CMAKE_SYSTEM_NAME}")
    endif()
endif()

if (NOT TARGET glesx::GLESv2)
    add_library(glesx::GLESv2 INTERFACE IMPORTED)
    if (EMSCRIPTEN)
        set_target_properties(glesx::GLESv2 PROPERTIES
            INTERFACE_LINK_OPTIONS "-sUSE_WEBGL2=1 -sFULL_ES3=1"
        )
    elseif (ANDROID)
        set_target_properties(glesx::GLESv2 PROPERTIES
            INTERFACE_LINK_LIBRARIES "GLESv3"
        )
    elseif (UNIX AND NOT APPLE)
        set_target_properties(glesx::GLESv2 PROPERTIES
            INTERFACE_LINK_LIBRARIES "GLESv2"
        )
    elseif (WIN32 OR IOS OR APPLE)
        find_dependency(unofficial-angle REQUIRED)
        set_target_properties(glesx::GLESv2 PROPERTIES
            INTERFACE_LINK_LIBRARIES "unofficial::angle::libGLESv2"
        )
    else()
        message(FATAL_ERROR "glesx::GLESv2 target is not available for ${CMAKE_SYSTEM_NAME}")
    endif()
endif()
