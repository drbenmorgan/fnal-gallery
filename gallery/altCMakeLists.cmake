include(ArtDictionary)

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
install(FILES
  AssnsBranchData.h
  BranchData.h
  BranchMapReader.h
  DataGetterHelper.h
  Event.h
  EventHistoryGetter.h
  EventNavigator.h
  FindMaker.h
  Handle.h
  TypeLabelInstanceKey.h
  ValidHandle.h
  throwFunctions.h
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
  )

# Must include dirs as art/build_dictionary don't understand genexs yet
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${cetlib_INCLUDE_DIR})
include_directories(${ROOT_INCLUDE_DIRS})
include_directories(${Boost_INCLUDE_DIRS})
art_dictionary(DICTIONARY_LIBRARIES gallery)


if(BUILD_TESTING)
  add_subdirectory(test)
endif()

