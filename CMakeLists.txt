cmake_minimum_required(VERSION 3.15)
project(cmake-conan-exp CXX)

set(CMAKE_CXX_STANDARD 17)

find_package(fmt REQUIRED)
find_package(caf REQUIRED)

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} fmt::fmt caf::caf)