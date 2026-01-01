# - Find URCU
# Find the URCU library
#
# This module defines the following variables:
#    URCU_FOUND       = Was URCU found or not?
#    URCU_LIBRARIES   = The list of libraries to link to when using URCU
#    URCU_INCLUDE_DIRS = The path to URCU include directory(s)
#    URCU_LIB         = The library path (for compatibility)
#    URCU_INC         = The include path (for compatibility)
#
# This module defines the following IMPORTED targets:
#    URCU::urcu       = The base URCU library
#    URCU::urcu-bp    = The bulletproof URCU library
#    URCU::urcu-qsbr  = The QSBR URCU library
#    URCU::urcu-memb  = The membarrier URCU library
#    URCU::urcu-mb    = The memory barrier URCU library

find_path(URCU_INCLUDE_DIR urcu.h)

set(URCU_COMPONENTS urcu urcu-bp urcu-qsbr urcu-memb urcu-mb)
set(URCU_LIBRARIES)

foreach(comp IN LISTS URCU_COMPONENTS)
  find_library(URCU_${comp}_LIBRARY ${comp})
  if(URCU_${comp}_LIBRARY)
    list(APPEND URCU_LIBRARIES ${URCU_${comp}_LIBRARY})
    add_library(URCU::${comp} SHARED IMPORTED)
    set_target_properties(URCU::${comp} PROPERTIES
      IMPORTED_LOCATION "${URCU_${comp}_LIBRARY}"
      INTERFACE_INCLUDE_DIRECTORIES "${URCU_INCLUDE_DIR}"
    )
  endif()
endforeach()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(URCU REQUIRED_VARS URCU_INCLUDE_DIR)

mark_as_advanced(URCU_INCLUDE_DIR)