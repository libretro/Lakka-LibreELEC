project(game.libretro.mame2003)

cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

enable_language(CXX)

find_package(kodi REQUIRED)
find_package(libretro-mame2003 REQUIRED)

set(DEPLIBS mame2003)
set(MAME2003_CUSTOM_BINARY ${MAME2003_LIB}
                       ${PROJECT_NAME}${CMAKE_SHARED_LIBRARY_SUFFIX} mame2003)

build_addon(${PROJECT_NAME} MAME2003 DEPLIBS)
