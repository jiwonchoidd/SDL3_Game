@echo off

if not exist build (
    mkdir build
)

cmake -DBUILD_SHARED_LIBS=OFF -S . -B build -G "Visual Studio 17 2022" -A x64

REM 빌드 실행
cmake --build build --config Release

REM 실행 파일 실행
build\Release\sdl_starter.exe

@pause