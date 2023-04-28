cmake_minimum_required(VERSION 3.0.0)
# ----------------------------------------------------------------------------
#  CMake for opencv dnn module jni brige
#
#    From the off-tree build directory, invoke:
#      $ cmake <PATH_TO_OPENCV_ROOT>
#
# ----------------------------------------------------------------------------


set(CMAKE_CXX_STANDARD 17)
set(BUILD_TESTS OFF)
set(BUILD_FAT_JAVA_LIB ON)
set(BUILD_SHARED_LIBS OFF)
set(BUILD_LIST "imgcodecs,dnn,objdetect,java" CACHE STRING "Modules to build")
set(WITH_TIFF OFF)
set(WITH_SPNG OFF)

add_compile_options(-Os -flto)

add_subdirectory(opencv)

project(cvface_project)
