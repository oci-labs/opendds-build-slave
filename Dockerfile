# Image for build GitHub Pull Requests for OpenDDS
FROM debian:stretch

RUN apt-get update && apt-get -y --fix-missing install \
    curl \
    g++ \
    git \
    gnupg \
    libfindbin-libs-perl \
    libxerces-c-dev \
    libssl-dev \
    make \
    openjdk-8-jdk-headless

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y --no-install-recommends nodejs

ENV MPC_ROOT=/opt/MPC \
    ACE_ROOT=/opt/ACE_TAO/ACE \
    TAO_ROOT=/opt/ACE_TAO/TAO \
    LD_LIBRARY_PATH=/opt/ACE_TAO/ACE/lib

COPY autobuild /opt/autobuild
COPY MPC ${MPC_ROOT}
COPY ACE_TAO /opt/ACE_TAO
COPY config.h ${ACE_ROOT}/ace/config.h
COPY platform_macros.GNU ${ACE_ROOT}/include/makeinclude/platform_macros.GNU
COPY default.features ${ACE_ROOT}/bin/MakeProjectCreator/config/default.features
COPY agent.jar /opt/jenkins/agent.jar
COPY run.sh /opt/jenkins/run.sh

RUN ${ACE_ROOT}/bin/mwc.pl -type gnuace ${TAO_ROOT}/TAO_ACE.mwc && \
    cd ${TAO_ROOT} && \
    make -s depend && \
    make

ENTRYPOINT ["/opt/jenkins/run.sh"]
