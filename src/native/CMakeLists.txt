# Set the minimum version of CMake that can be used to build the library.
cmake_minimum_required(VERSION 3.4.1)

# Define the project name.
project(yuv_converter)

# Add the C++ source file to the build.
add_library(
    # Set the name of the library.
    yuv_converter

    # Set the library as a shared library.
    SHARED

    # Provide a relative path to your source file(s).
    yuv_converter.cpp)

# Find and link any necessary libraries, for example, the log library for debugging.
find_library(
    # Sets the name of the path variable.
    log-lib

    # Specifies the name of the NDK library that
    # you want CMake to locate.
    log)

# Link the library to the log library, so you can use it in your C++ code.
target_link_libraries(
    # Specifies the target library.
    yuv_converter

    # Links the log library to the target library.
    ${log-lib})
