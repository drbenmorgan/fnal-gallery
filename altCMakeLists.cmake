# ======================================================================
#  gallery main build file
#
#  cd .../path/to/build/directory
#  cmake [-DCMAKE_INSTALL_PREFIX=/install/path] <pathtosource>
#  make
#  make test
#  make install
#  make package (builds distribution tarfile)
# ======================================================================

# - Project setup
cmake_minimum_required(VERSION 3.3)
project(gallery VERSION 1.3.7)

# CMAKE_MODULE_PATH not picked up from the environemnt?
# Needed for FindROOT from ROOT
list(INSERT CMAKE_MODULE_PATH 0 $ENV{CMAKE_MODULE_PATH})

#-----------------------------------------------------------------------
# Standard and Custom CMake Modules
#
# - Cetbuildtools, version2
find_package(cetbuildtools2 0.1.0 REQUIRED)
list(INSERT CMAKE_MODULE_PATH 0 ${cetbuildtools2_MODULE_PATH})
include(CetInstallDirs)
include(CetCMakeSettings)
include(CetCompilerSettings)
include(CetTest)

# C++ Standard Config
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(canvas_COMPILE_FEATURES
  cxx_auto_type
  cxx_generic_lambdas
  )

# these are minimum required versions, not the actual product versions
find_package(canvas REQUIRED)
find_package(cetlib REQUIRED)
find_package(ROOT 6.0.0 REQUIRED)

# art_dictionary
include(ArtDictionary)

# source
add_subdirectory(gallery)

# ups - table and config files
#add_subdirectory(ups)

# packaging utility
#include(UseCPack)
