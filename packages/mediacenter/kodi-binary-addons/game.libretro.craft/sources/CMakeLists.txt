project(game.libretro.craft)

cmake_minimum_required(VERSION 2.6)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR})

enable_language(CXX)

find_package(kodi REQUIRED)
find_package(libretro-craft REQUIRED)

set(DEPLIBS craft)
set(CRAFT_CUSTOM_BINARY ${CRAFT_LIB}
                              game.libretro.craft${CMAKE_SHARED_LIBRARY_SUFFIX} craft)

build_addon(game.libretro.craft CRAFT DEPLIBS)
