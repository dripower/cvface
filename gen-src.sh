#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
JAVA_SO_VERSION=470
mkdir -p build
cd build/
cmake ../
make -j 4
LIB_PATH=$SCRIPT_DIR/cvface/src/gen/lib/opencv
JAVA_PATH=$SCRIPT_DIR/cvface/src/gen/java/
mkdir -p $LIB_PATH
mkdir -p $JAVA_PATH

cp opencv/lib/libopencv_java${JAVA_SO_VERSION}.so $LIB_PATH
cp -r opencv/modules/java/jar/opencv/java/* $JAVA_PATH
