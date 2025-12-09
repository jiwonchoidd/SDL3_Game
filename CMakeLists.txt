cmake_minimum_required(VERSION 3.25.1)

project(sdl_game)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# set the output directory for built objects.
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/$<CONFIGURATION>")

include(FetchContent)

# SDL 경로 확인
if(EXISTS "${CMAKE_SOURCE_DIR}/vendored/SDL/CMakeLists.txt")
    # vendored/SDL 안에 CMakeLists.txt가 있으면 그대로 사용
    add_subdirectory(vendored/SDL EXCLUDE_FROM_ALL)
else()
    # 없으면 SDL을 자동으로 다운로드
    message(STATUS "vendored/SDL not found, fetching SDL3 from GitHub...")
    FetchContent_Declare(
        SDL3
        GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
        GIT_TAG release-3.2.2   # 원하는 SDL 버전 태그
    )
    FetchContent_MakeAvailable(SDL3)
endif()

add_executable(${PROJECT_NAME}
    src/main.cpp
    vendored/imgui/imgui.cpp
    vendored/imgui/imgui_draw.cpp
    vendored/imgui/imgui_demo.cpp
    vendored/imgui/imgui_impl_sdl3.cpp
    vendored/imgui/imgui_impl_sdlrenderer3.cpp
    vendored/imgui/imgui_tables.cpp
    vendored/imgui/imgui_widgets.cpp
)

# Link to the actual SDL3 library.
target_link_libraries(${PROJECT_NAME} PRIVATE SDL3::SDL3)

target_include_directories(${PROJECT_NAME} PRIVATE
    src
    vendored/entt
    vendored/imgui
)