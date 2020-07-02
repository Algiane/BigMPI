add_custom_command(
  OUTPUT "${CMAKE_CURRENT_SOURCE_DIR}/bigmpiconf.h"
  COMMAND "./autogen.sh"
  COMMAND "./configure"
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/..")

file(GLOB SOURCES "${CMAKE_CURRENT_SOURCE_DIR}/*.c")
add_library(bigmpi ${LIB_LINKAGE_TYPE} ${SOURCES} "bigmpiconf.h")

target_link_libraries ( bigmpi ${MPI_LIBRARIES} )

#Check MPI_File_i[read|write]* support
unset(HAVE_RECENT_MPI CACHE)
include(CheckSymbolExists)
list ( APPEND CMAKE_REQUIRED_LIBRARIES ${MPI_LIBRARY} )
list ( APPEND CMAKE_REQUIRED_INCLUDES ${MPI_INCLUDE_PATH} )
check_symbol_exists(MPI_File_iread_at_all mpi.h HAVE_RECENT_MPI)
mark_as_advanced(HAVE_RECENT_MPI)

if ( HAVE_RECENT_MPI )
  add_definitions(-DHAVE_RECENT_MPI)
endif ()

set_target_properties ( bigmpi PROPERTIES PUBLIC_HEADER "bigmpi.h")

if (NOT CMAKE_INSTALL_LIBDIR)
  set(CMAKE_INSTALL_LIBDIR lib)
endif()

if (NOT CMAKE_INSTALL_INCLUDEDIR)
  set(CMAKE_INSTALL_INCLUDEDIR include)
endif()

install(TARGETS bigmpi
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
    COMPONENT lib
    )
