project(game.libretro.mame2014)

cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

enable_language(CXX)

find_package(kodi REQUIRED)
find_package(libretro-mame2014 REQUIRED)

set(DEPLIBS mame2014)
set(MAME2014_CUSTOM_BINARY ${MAME2014_LIB}
                       ${PROJECT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} mame2014)

build_addon(${PROJECT_NAME} MAME2014 DEPLIBS)
