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
set(OPENCV_FORCE_3RDPARTY_BUILD ON)
set(BUILD_FAT_JAVA_LIB ON)
set(BUILD_SHARED_LIBS OFF)
set(BUILD_LIST "dnn,objdetect,java")
set(WITH_V4l OFF)
set(WITH_LIBV4L ON)
add_subdirectory(opencv)

project(cvface_project)
