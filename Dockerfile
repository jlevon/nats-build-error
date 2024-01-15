FROM centos:8

RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y install dnf-plugins-core
RUN yum config-manager --set-enabled powertools
RUN yum -y install protobuf-c-devel git gcc gcc-c++ cmake3 openssl-devel
RUN yum -y install ninja-build meson
RUN git clone https://github.com/jlevon/nats-build-error.git
WORKDIR "/nats-build-error"
RUN git submodule update --init
RUN meson setup build/
RUN ninja -C build/
