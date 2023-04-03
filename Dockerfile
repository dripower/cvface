FROM bellsoft/liberica-openjdk-centos:11.0.17-7
RUN curl -L https://github.com/Kitware/CMake/releases/download/v3.25.2/cmake-3.25.2-linux-x86_64.tar.gz | tar xz -C /usr/local/ && mv /usr/local/cmake* /usr/local/cmake
RUN ln -s /usr/local/cmake/bin/cmake /usr/local/bin/cmake
RUN yum install -y centos-release-scl && yum install -y devtoolset-11 && yum clean all
