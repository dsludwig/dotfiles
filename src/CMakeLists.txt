cmake_minimum_required(VERSION 3.2)
project(project_completion)

set(SOURCE_FILES main.cpp)

add_executable(project_completion ${SOURCE_FILES})
install(TARGETS project_completion DESTINATION ${COMPLETION_INSTALL_BIN_DIR})
