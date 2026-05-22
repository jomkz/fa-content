cmake_minimum_required(VERSION 3.25)
project(fa-content VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(-Wall -Wextra -Wpedantic)
endif()

# Pull in fx_lib from the fighters-codex submodule
# add_subdirectory(extern/fx_lib)

# Bridge source trees added here as Phase 1 Workstream B progresses
