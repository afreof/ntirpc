########### next target ###############

SET(ntirpcmonitoring_SRCS
  monitoring.cc
)

SET(ntirpcmonitoring_public_HDRS
  include/monitoring.h
)

add_library(ntirpcmonitoring SHARED ${ntirpcmonitoring_SRCS})
target_compile_features(ntirpcmonitoring PRIVATE cxx_std_17)
add_sanitizers(ntirpcmonitoring)
set_target_properties(ntirpcmonitoring PROPERTIES
  VERSION ${NTIRPC_VERSION}
  SOVERSION "${NTIRPC_MAJOR_VERSION}${NTIRPC_MINOR_VERSION}"
  PUBLIC_HEADER ${ntirpcmonitoring_public_HDRS}
  )
target_include_directories(ntirpcmonitoring
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}/ntirpc>
  PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/prometheus-cpp-lite/core/include
  ${PROJECT_BINARY_DIR}
)
target_compile_options(ntirpcmonitoring PRIVATE -pedantic-errors -Werror -Wall -Wextra)
install(TARGETS ntirpcmonitoring
  EXPORT ntirpcTargets
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/ntirpc
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
