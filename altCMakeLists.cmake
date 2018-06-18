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
project(gallery VERSION 1.8.2)

#-----------------------------------------------------------------------
# Standard and Custom CMake Modules
#
# - Cetbuildtools, version2
find_package(cetbuildtools2 0.5.0 REQUIRED)
list(INSERT CMAKE_MODULE_PATH 0 ${cetbuildtools2_MODULE_PATH})
set(CET_COMPILER_CXX_STANDARD_MINIMUM 14)
include(CetInstallDirs)
include(CetCMakeSettings)
include(CetCompilerSettings)

# Find direct dependencies
find_package(canvas_root_io REQUIRED)
find_package(canvas)
find_package(cetlib REQUIRED)
find_package(ROOT 6 REQUIRED)

# art_dictionary
include(ArtDictionary)

# source
add_subdirectory(gallery)

# ups - table and config files
#add_subdirectory(ups)

# packaging utility
#include(UseCPack)
