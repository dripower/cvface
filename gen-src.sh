#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
JAVA_SO_VERSION=$(awk '
  /#define CV_VERSION_MAJOR/ { major = $3 }
  /#define CV_VERSION_MINOR/ { minor = $3 }
  /#define CV_VERSION_REVISION/ { patch = $3 }
  END { printf "%d%d%d", major, minor, patch }
' "$SCRIPT_DIR/opencv/modules/core/include/opencv2/core/version.hpp")
mkdir -p build
cd build/
cmake -DBUILD_LIST='imgcodecs,dnn,objdetect,java' ../
cmake --build .
LIB_PATH=$SCRIPT_DIR/cvface/src/gen/lib/opencv
JAVA_PATH=$SCRIPT_DIR/cvface/src/gen/java/
mkdir -p $LIB_PATH
mkdir -p $JAVA_PATH

cp opencv/lib/libopencv_java${JAVA_SO_VERSION}.so $LIB_PATH
cp -r opencv/modules/java/jar/opencv/java/* $JAVA_PATH
