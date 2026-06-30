FROM centos:7

SHELL ["/bin/bash", "-lc"]

RUN sed -i \
      -e 's|^mirrorlist=|#mirrorlist=|g' \
      -e 's|^#baseurl=http://mirror.centos.org/centos/$releasever|baseurl=https://mirrors.cloud.tencent.com/centos-vault/7.9.2009|g' \
      /etc/yum.repos.d/CentOS-*.repo \
    && yum install -y centos-release-scl epel-release \
    && sed -i \
      -e 's|^mirrorlist=|#mirrorlist=|g' \
      -e 's|^#baseurl=http://mirror.centos.org/centos/$releasever|baseurl=https://mirrors.cloud.tencent.com/centos-vault/7.9.2009|g' \
      -e 's|^#baseurl=http://mirror.centos.org/centos/7/sclo|baseurl=https://mirrors.cloud.tencent.com/centos-vault/7.9.2009/sclo|g' \
      -e 's|^# baseurl=http://mirror.centos.org/centos/7/sclo|baseurl=https://mirrors.cloud.tencent.com/centos-vault/7.9.2009/sclo|g' \
      -e 's|^#baseurl=http://download.example/pub/epel/7/$basearch|baseurl=https://mirrors.cloud.tencent.com/epel/7/$basearch|g' \
      -e 's|^#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch|baseurl=https://mirrors.cloud.tencent.com/epel/7/$basearch|g' \
      -e 's|^#baseurl=https://download.fedoraproject.org/pub/epel/7/$basearch|baseurl=https://mirrors.cloud.tencent.com/epel/7/$basearch|g' \
      -e 's|^metalink=|#metalink=|g' \
      /etc/yum.repos.d/*.repo \
    && yum install -y \
      cmake3 \
      devtoolset-11-binutils \
      devtoolset-11-gcc \
      devtoolset-11-gcc-c++ \
      file \
      findutils \
      git \
      gzip \
      make \
      patch \
      pkgconfig \
      tar \
      unzip \
      which \
      zlib-devel \
    && yum clean all \
    && rm -rf /var/cache/yum

ENV CVFACE_SRC=/workspace
ENV CVFACE_BUILD=/out/build
ENV CVFACE_OUT=/out/gen
ENV BUILD_LIST=imgcodecs,dnn,objdetect,java

CMD : "${JAVA_HOME:?mount a JDK and pass -e JAVA_HOME=/path/in/container}" \
    && source /opt/rh/devtoolset-11/enable \
    && export PATH="${JAVA_HOME}/bin:${PATH}" \
    && cmake3 -S "${CVFACE_SRC}" -B "${CVFACE_BUILD}" -DBUILD_LIST="${BUILD_LIST}" \
    && cmake3 --build "${CVFACE_BUILD}" --target opencv_java -- -j"${JOBS:-$(nproc)}" \
    && rm -rf "${CVFACE_OUT}" \
    && mkdir -p "${CVFACE_OUT}/lib/opencv" "${CVFACE_OUT}/java" \
    && cp "${CVFACE_BUILD}"/opencv/lib/libopencv_java*.so "${CVFACE_OUT}/lib/opencv/" \
    && strip --strip-unneeded "${CVFACE_OUT}"/lib/opencv/libopencv_java*.so \
    && cp -a "${CVFACE_BUILD}"/opencv/modules/java_bindings_generator/gen/java/. "${CVFACE_OUT}/java/"
