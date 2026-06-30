# Opencv based face lib(jni build)

A custom build of opencv 5.x with objdetect, dnn (used for face recoginition).

# Build requirements

* CMake 3.13 +
* CXX 17 compatible toolchain
* Opencv required libs

# Build instructions
+ Run `gen-src.sh` generate the dynamic lib and java source into the `cvface/src/gen` folder.
+ Run `gradle build` in `cvface` fold to build jar.

# CentOS 7 docker build

The Docker image only provides the CentOS 7 compiler toolchain. Mount the source tree, a local JDK, and an output directory:

```bash
docker build -t cvface-centos7-build .
mkdir -p docker-out
docker run --rm \
  -v "$PWD:/workspace" \
  -v "$JAVA_HOME:/jdk:ro" \
  -v "$PWD/docker-out:/out" \
  -e JAVA_HOME=/jdk \
  cvface-centos7-build
```

Generated files are written under `docker-out/gen`. Gradle packaging should be run outside this image.


# What's changed ?

* Only face recoginition related modules are build.
* Build fatlib (single shared library) by default.
* Removed `finalize` / `Cleaner`, resource should be released manually.
