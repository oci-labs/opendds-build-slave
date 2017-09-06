# Image for build GitHub Pull Requests for OpenDDS
FROM debian

RUN apt-get update && apt-get -y --fix-missing install \
    bison \
    bzip2 \
    curl \
    flex \
    g++ \
    git \
    libfindbin-libs-perl \
    libgtk-3-dev \
    libpcap-dev \
    libqt4-dev \
    libqt4-dev-bin \
    libxerces-c-dev \
    make \
    openjdk-8-jdk-headless \
    pkg-config \
    python

RUN curl https://1.na.dl.wireshark.org/src/all-versions/wireshark-1.12.13.tar.bz2 -o /opt/wireshark-1.12.13.tar.bz2 && \
    cd /opt && \
    tar xjf wireshark-1.12.13.tar.bz2 && \
    cd wireshark-1.12.13 && \
    ./configure && \
    make

ENV WIRESHARK_SRC=/opt/wireshark-1.12.13 \
    MPC_ROOT=/opt/MPC \
    ACE_ROOT=/opt/ACE_TAO/ACE \
    TAO_ROOT=/opt/ACE_TAO/TAO \
    LD_LIBRARY_PATH=/opt/ACE_TAO/ACE/lib \
    QTDIR=/usr \
    QT4_INCDIR=/usr/include/qt4

COPY autobuild /opt/autobuild
COPY MPC ${MPC_ROOT}
COPY ACE_TAO /opt/ACE_TAO
COPY config.h ${ACE_ROOT}/ace/config.h
COPY platform_macros.GNU ${ACE_ROOT}/include/makeinclude/platform_macros.GNU
COPY default.features ${ACE_ROOT}/bin/MakeProjectCreator/config/default.features
COPY slave.jar /opt/slave.jar

RUN ${ACE_ROOT}/bin/mwc.pl -type gnuace ${TAO_ROOT}/TAO_ACE.mwc && \
    cd ${TAO_ROOT} && \
    make -s depend && \
    make

WORKDIR /opt/workspace
CMD /opt/autobuild/autobuild.pl /opt/workspace/config.xml
