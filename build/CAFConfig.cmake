########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(CAF_FIND_QUIETLY)
    set(CAF_MESSAGE_MODE VERBOSE)
else()
    set(CAF_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/CAFTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${caf_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(CAF_VERSION_STRING "1.0.0")
set(CAF_INCLUDE_DIRS ${caf_INCLUDE_DIRS_RELEASE} )
set(CAF_INCLUDE_DIR ${caf_INCLUDE_DIRS_RELEASE} )
set(CAF_LIBRARIES ${caf_LIBRARIES_RELEASE} )
set(CAF_DEFINITIONS ${caf_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${caf_BUILD_MODULES_PATHS_RELEASE} )
    message(${CAF_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


