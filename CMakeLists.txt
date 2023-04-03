cmake_minimum_required(VERSION 3.0.0)
# ----------------------------------------------------------------------------
#  CMake for opencv dnn module jni brige
#
#    From the off-tree build directory, invoke:
#      $ cmake <PATH_TO_OPENCV_ROOT>
#
# ----------------------------------------------------------------------------


set(CMAKE_CXX_STANDARD 17)
set(BUILD_LIST "core,dnn,objdetect,java")
set(BUILD_TESTS OFF)
set(WITH_GTK OFF)
set(WITH_FFMPEG OFF)
set(WITH_GSTREAMER OFF)
set(WITH_1394 OFF)
project(cvface_project)

add_subdirectory(opencv)
