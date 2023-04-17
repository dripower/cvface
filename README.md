# Opencv based face lib(jni build)

A custom build of opencv 4.7.0 with objectdetect, dnn (used for face recoginition).

# Build requirements

* CMake 3.3 +
* CXX 17 compatible toolchain
* Opencv required libs

# Build instructions
+ Run `gen-src.sh` generate the dynamic and java source into the `cvface/src/gen` folder.
+ Run `gradle build` in `cvface` fold to build jar.
