project(game.libretro.mame2010)

cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

enable_language(CXX)

find_package(kodi REQUIRED)
find_package(libretro-mame2010 REQUIRED)

set(DEPLIBS mame2010)
set(MAME2010_CUSTOM_BINARY ${MAME2010_LIB}
                       ${PROJECT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} mame2010)

build_addon(${PROJECT_NAME} MAME2010 DEPLIBS)
