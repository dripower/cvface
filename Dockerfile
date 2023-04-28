FROM jilen/centos7-toolset11-java11
RUN curl -L -o /opt/ant.tar.gz https://dlcdn.apache.org/ant/binaries/apache-ant-1.10.13-bin.tar.gz && cd /tmp/ && tar xvf /opt/ant.tar.gz && mv apache-ant-* /opt/ant && rm /opt/ant.tar.gz
RUN ls /opt/ant/
RUN ln -s /opt/ant/bin/ant /usr/bin/ant
RUN ls /opt/ant/ && ant -version
RUN mkdir -p /opt/cvface/
ADD ./opencv  /opt/cvface/opencv
ADD ./CMakeLists.txt /opt/cvface/CMakeLists.txt
WORKDIR /opt/cvface/build
RUN source /opt/rh/devtoolset-11/enable && JAVA_INCLUDE_PATH=/usr/lib/jvm/bellsoft-java17-lite.x86_64/include/ /usr/local/cmake/bin/cmake .. && make && cp opencv/lib/*.so /opt/cvface && cd /opt/cvface && rm -rf build
