project(game.libretro.mame2000)

cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

enable_language(CXX)

find_package(kodi REQUIRED)
find_package(libretro-mame2000 REQUIRED)

set(DEPLIBS mame2000)
set(MAME2000_CUSTOM_BINARY ${MAME2000_LIB}
                       ${PROJECT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} mame2000)

build_addon(${PROJECT_NAME} MAME2000 DEPLIBS)
