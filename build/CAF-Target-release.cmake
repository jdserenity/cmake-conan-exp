# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(caf_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(caf_FRAMEWORKS_FOUND_RELEASE "${caf_FRAMEWORKS_RELEASE}" "${caf_FRAMEWORK_DIRS_RELEASE}")

set(caf_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET caf_DEPS_TARGET)
    add_library(caf_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET caf_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${caf_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${caf_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:CAF::core;CAF::io;openssl::openssl>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### caf_DEPS_TARGET to all of them
conan_package_library_targets("${caf_LIBS_RELEASE}"    # libraries
                              "${caf_LIB_DIRS_RELEASE}" # package_libdir
                              "${caf_BIN_DIRS_RELEASE}" # package_bindir
                              "${caf_LIBRARY_TYPE_RELEASE}"
                              "${caf_IS_HOST_WINDOWS_RELEASE}"
                              caf_DEPS_TARGET
                              caf_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "caf"    # package_name
                              "${caf_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${caf_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## COMPONENTS TARGET PROPERTIES Release ########################################

    ########## COMPONENT CAF::openssl #############

        set(caf_CAF_openssl_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(caf_CAF_openssl_FRAMEWORKS_FOUND_RELEASE "${caf_CAF_openssl_FRAMEWORKS_RELEASE}" "${caf_CAF_openssl_FRAMEWORK_DIRS_RELEASE}")

        set(caf_CAF_openssl_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET caf_CAF_openssl_DEPS_TARGET)
            add_library(caf_CAF_openssl_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET caf_CAF_openssl_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${caf_CAF_openssl_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_openssl_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_openssl_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'caf_CAF_openssl_DEPS_TARGET' to all of them
        conan_package_library_targets("${caf_CAF_openssl_LIBS_RELEASE}"
                              "${caf_CAF_openssl_LIB_DIRS_RELEASE}"
                              "${caf_CAF_openssl_BIN_DIRS_RELEASE}" # package_bindir
                              "${caf_CAF_openssl_LIBRARY_TYPE_RELEASE}"
                              "${caf_CAF_openssl_IS_HOST_WINDOWS_RELEASE}"
                              caf_CAF_openssl_DEPS_TARGET
                              caf_CAF_openssl_LIBRARIES_TARGETS
                              "_RELEASE"
                              "caf_CAF_openssl"
                              "${caf_CAF_openssl_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET CAF::openssl
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${caf_CAF_openssl_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_openssl_LIBRARIES_TARGETS}>
                     )

        if("${caf_CAF_openssl_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET CAF::openssl
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         caf_CAF_openssl_DEPS_TARGET)
        endif()

        set_property(TARGET CAF::openssl APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${caf_CAF_openssl_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET CAF::openssl APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${caf_CAF_openssl_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET CAF::openssl APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${caf_CAF_openssl_LIB_DIRS_RELEASE}>)
        set_property(TARGET CAF::openssl APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${caf_CAF_openssl_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET CAF::openssl APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${caf_CAF_openssl_COMPILE_OPTIONS_RELEASE}>)

    ########## COMPONENT CAF::io #############

        set(caf_CAF_io_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(caf_CAF_io_FRAMEWORKS_FOUND_RELEASE "${caf_CAF_io_FRAMEWORKS_RELEASE}" "${caf_CAF_io_FRAMEWORK_DIRS_RELEASE}")

        set(caf_CAF_io_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET caf_CAF_io_DEPS_TARGET)
            add_library(caf_CAF_io_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET caf_CAF_io_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${caf_CAF_io_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_io_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_io_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'caf_CAF_io_DEPS_TARGET' to all of them
        conan_package_library_targets("${caf_CAF_io_LIBS_RELEASE}"
                              "${caf_CAF_io_LIB_DIRS_RELEASE}"
                              "${caf_CAF_io_BIN_DIRS_RELEASE}" # package_bindir
                              "${caf_CAF_io_LIBRARY_TYPE_RELEASE}"
                              "${caf_CAF_io_IS_HOST_WINDOWS_RELEASE}"
                              caf_CAF_io_DEPS_TARGET
                              caf_CAF_io_LIBRARIES_TARGETS
                              "_RELEASE"
                              "caf_CAF_io"
                              "${caf_CAF_io_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET CAF::io
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${caf_CAF_io_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_io_LIBRARIES_TARGETS}>
                     )

        if("${caf_CAF_io_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET CAF::io
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         caf_CAF_io_DEPS_TARGET)
        endif()

        set_property(TARGET CAF::io APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${caf_CAF_io_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET CAF::io APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${caf_CAF_io_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET CAF::io APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${caf_CAF_io_LIB_DIRS_RELEASE}>)
        set_property(TARGET CAF::io APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${caf_CAF_io_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET CAF::io APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${caf_CAF_io_COMPILE_OPTIONS_RELEASE}>)

    ########## COMPONENT CAF::core #############

        set(caf_CAF_core_FRAMEWORKS_FOUND_RELEASE "")
        conan_find_apple_frameworks(caf_CAF_core_FRAMEWORKS_FOUND_RELEASE "${caf_CAF_core_FRAMEWORKS_RELEASE}" "${caf_CAF_core_FRAMEWORK_DIRS_RELEASE}")

        set(caf_CAF_core_LIBRARIES_TARGETS "")

        ######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
        if(NOT TARGET caf_CAF_core_DEPS_TARGET)
            add_library(caf_CAF_core_DEPS_TARGET INTERFACE IMPORTED)
        endif()

        set_property(TARGET caf_CAF_core_DEPS_TARGET
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${caf_CAF_core_FRAMEWORKS_FOUND_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_core_SYSTEM_LIBS_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_core_DEPENDENCIES_RELEASE}>
                     )

        ####### Find the libraries declared in cpp_info.component["xxx"].libs,
        ####### create an IMPORTED target for each one and link the 'caf_CAF_core_DEPS_TARGET' to all of them
        conan_package_library_targets("${caf_CAF_core_LIBS_RELEASE}"
                              "${caf_CAF_core_LIB_DIRS_RELEASE}"
                              "${caf_CAF_core_BIN_DIRS_RELEASE}" # package_bindir
                              "${caf_CAF_core_LIBRARY_TYPE_RELEASE}"
                              "${caf_CAF_core_IS_HOST_WINDOWS_RELEASE}"
                              caf_CAF_core_DEPS_TARGET
                              caf_CAF_core_LIBRARIES_TARGETS
                              "_RELEASE"
                              "caf_CAF_core"
                              "${caf_CAF_core_NO_SONAME_MODE_RELEASE}")


        ########## TARGET PROPERTIES #####################################
        set_property(TARGET CAF::core
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     $<$<CONFIG:Release>:${caf_CAF_core_OBJECTS_RELEASE}>
                     $<$<CONFIG:Release>:${caf_CAF_core_LIBRARIES_TARGETS}>
                     )

        if("${caf_CAF_core_LIBS_RELEASE}" STREQUAL "")
            # If the component is not declaring any "cpp_info.components['foo'].libs" the system, frameworks etc are not
            # linked to the imported targets and we need to do it to the global target
            set_property(TARGET CAF::core
                         APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                         caf_CAF_core_DEPS_TARGET)
        endif()

        set_property(TARGET CAF::core APPEND PROPERTY INTERFACE_LINK_OPTIONS
                     $<$<CONFIG:Release>:${caf_CAF_core_LINKER_FLAGS_RELEASE}>)
        set_property(TARGET CAF::core APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                     $<$<CONFIG:Release>:${caf_CAF_core_INCLUDE_DIRS_RELEASE}>)
        set_property(TARGET CAF::core APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                     $<$<CONFIG:Release>:${caf_CAF_core_LIB_DIRS_RELEASE}>)
        set_property(TARGET CAF::core APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                     $<$<CONFIG:Release>:${caf_CAF_core_COMPILE_DEFINITIONS_RELEASE}>)
        set_property(TARGET CAF::core APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                     $<$<CONFIG:Release>:${caf_CAF_core_COMPILE_OPTIONS_RELEASE}>)

    ########## AGGREGATED GLOBAL TARGET WITH THE COMPONENTS #####################
    set_property(TARGET caf::caf APPEND PROPERTY INTERFACE_LINK_LIBRARIES CAF::openssl)
    set_property(TARGET caf::caf APPEND PROPERTY INTERFACE_LINK_LIBRARIES CAF::io)
    set_property(TARGET caf::caf APPEND PROPERTY INTERFACE_LINK_LIBRARIES CAF::core)

########## For the modules (FindXXX)
set(caf_LIBRARIES_RELEASE caf::caf)
