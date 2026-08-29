cmake_minimum_required(VERSION 3.28)
project({{PROJECT_NAME}} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 26)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_SCAN_FOR_MODULES OFF)

find_package(SFML 2.6 COMPONENTS graphics window system QUIET)

if(NOT SFML_FOUND)
    message(STATUS "SFML not found locally, fetching via FetchContent...")
    include(FetchContent)
    FetchContent_Declare(
        sfml
        GIT_REPOSITORY https://github.com/SFML/SFML.git
        GIT_TAG 2.6.x
    )
    FetchContent_MakeAvailable(sfml)
endif()

add_executable(${PROJECT_NAME}
    src/main.cpp
    src/game.cpp
    src/player.cpp
    src/enemy.cpp
    src/bullet.cpp
)

target_link_libraries(${PROJECT_NAME} PRIVATE sfml-graphics sfml-window sfml-system)
