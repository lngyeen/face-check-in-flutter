# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(yuv_converter_library VERSION 0.0.1 LANGUAGES C)

add_library(yuv_converter SHARED
  "yuv_converter.c"
)

set_target_properties(yuv_converter PROPERTIES
  PUBLIC_HEADER yuv_converter.h
  OUTPUT_NAME "yuv_converter"
)

target_compile_definitions(yuv_converter PUBLIC DART_SHARED_LIB)

if (ANDROID)
  # Support Android 15 16k page size
  target_link_options(yuv_converter PRIVATE "-Wl,-z,max-page-size=16384")
endif()
