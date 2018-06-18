
add_library(gallery SHARED
  AssnsBranchData.cc
  AssnsBranchData.h
  BranchData.cc
  BranchData.h
  BranchMapReader.cc
  BranchMapReader.h
  DataGetterHelper.cc
  DataGetterHelper.h
  Event.cc
  Event.h
  EventHistoryGetter.cc
  EventHistoryGetter.h
  EventNavigator.cc
  EventNavigator.h
  FindMaker.cc
  FindMaker.h
  Handle.h
  TypeLabelInstanceKey.h
  ValidHandle.cc
  ValidHandle.h
  throwFunctions.cc
  throwFunctions.h
  )

target_include_directories(gallery
  PUBLIC
   $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
   $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
   ${ROOT_INCLUDE_DIRS}
   )

 target_link_libraries(gallery
  PUBLIC
    canvas_root_io::canvas_root_io
    canvas::canvas
    cetlib::cetlib
    ${ROOT_Core_LIBRARY}
    ${ROOT_RIO_LIBRARY}
    ${ROOT_Tree_LIBRARY}
    )

install(TARGETS gallery
  EXPORT ${PROJECT_NAME}Targets
  DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )
install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/"
  DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}"
  FILES_MATCHING PATTERN "*.h"
  PATTERN "test" EXCLUDE
  )


# Must include dirs as art/build_dictionary don't understand genexs yet
include_directories(${PROJECT_SOURCE_DIR})
art_dictionary(DICTIONARY_LIBRARIES gallery DICT_NAME_VAR _dictlib)
# Use get_property to avoid nested genex expansion issue
get_target_property(_rootmap_file ${_dictlib}_dict ROOTMAP_FILE)
get_target_property(_pcm_file ${_dictlib}_dict PCM_FILE)
install(TARGETS ${_dictlib}_dict
  EXPORT ${PROJECT_NAME}Targets
  DESTINATION ${CMAKE_INSTALL_LIBDIR})
install(FILES ${_rootmap_file} ${_pcm_file}
  DESTINATION ${CMAKE_INSTALL_LIBDIR}
  )


if(BUILD_TESTING)
  # Create interface
  set(ROOT_CORE "${ROOT_Core_LIBRARY}")
  include_directories(${ROOT_INCLUDE_DIRS})
  include_directories($<TARGET_PROPERTY:canvas::canvas,INTERFACE_INCLUDE_DIRECTORIES>)

  add_subdirectory(test)
endif()

# Support files
#-----------------------------------------------------------------------
# Create exports file(s)
include(CMakePackageConfigHelpers)

# - Common to both trees
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
  COMPATIBILITY SameMajorVersion
  )

# - Build tree (EXPORT only for now, config file needs some thought,
#   dependent on the use of multiconfig)
export(
  EXPORT ${PROJECT_NAME}Targets
  NAMESPACE ${PROJECT_NAME}::
  FILE "${PROJECT_BINARY_DIR}/${PROJECT_NAME}Targets.cmake"
  )

# - Install tree
configure_package_config_file("${PROJECT_SOURCE_DIR}/${PROJECT_NAME}Config.cmake.in"
  "${PROJECT_BINARY_DIR}/InstallCMakeFiles/${PROJECT_NAME}Config.cmake"
  INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
  PATH_VARS CMAKE_INSTALL_INCLUDEDIR
  )

install(
  FILES
    "${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake"
    "${PROJECT_BINARY_DIR}/InstallCMakeFiles/${PROJECT_NAME}Config.cmake"
  DESTINATION
    "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
    )

install(
  EXPORT ${PROJECT_NAME}Targets
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}"
  )

