cmake_minimum_required(VERSION 3.2)

project(cmake-project-template)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")

set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR})
set(COMPLETION_INSTALL_BIN_DIR ${CMAKE_INSTALL_PREFIX}/bash/completion_scripts)

add_subdirectory(src)
# add_subdirectory(test)
