include(ArtDictionary)

set(gallery_SOURCES
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
  HistoryGetterBase.cc
  HistoryGetterBase.h
  TypeLabelInstanceKey.h
  ValidHandle.cc
  ValidHandle.h
  throwFunctions.cc
  throwFunctions.h
  )

add_library(gallery SHARED ${gallery_SOURCES})
target_include_directories(gallery
  PUBLIC
   $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
   $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
   ${ROOT_INCLUDE_DIRS}
   )
target_link_libraries(gallery
  PUBLIC
    canvas::canvas_Persistency_Common
    canvas::canvas_Persistency_Provenance
    canvas::canvas_Utilities
    cetlib::cetlib
    ${ROOT_Core_LIBRARY}
    ${ROOT_RIO_LIBRARY}
    ${ROOT_Tree_LIBRARY}
    )


# Must include dirs as art/build_dictionary don't understand genexs yet
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${cetlib_INCLUDE_DIR})
include_directories(${ROOT_INCLUDE_DIRS})
art_dictionary(DICTIONARY_LIBRARIES gallery)


