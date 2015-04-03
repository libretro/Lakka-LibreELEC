project(jsoncpp)

cmake_minimum_required(VERSION 2.6)
enable_language(CXX)

set(SOURCES src/lib_json/json_reader.cpp
            src/lib_json/json_value.cpp
            src/lib_json/json_writer.cpp)

include_directories(${PROJECT_SOURCE_DIR}/include)

add_library(jsoncpp ${SOURCES})

install(TARGETS jsoncpp DESTINATION ${CMAKE_INSTALL_PREFIX}/lib) 
install(DIRECTORY include/json DESTINATION ${CMAKE_INSTALL_PREFIX}/include/jsoncpp)
