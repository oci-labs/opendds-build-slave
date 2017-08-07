# Image for build GitHub Pull Requests for OpenDDS
FROM debian

RUN apt-get update && apt-get -y --fix-missing install libfindbin-libs-perl make g++ libxerces-c-dev git libqt4-dev-bin libqt4-dev

COPY autobuild /opt/autobuild
COPY MPC /opt/MPC
COPY ACE_TAO /opt/ACE_TAO

ENV MPC_ROOT /opt/MPC
ENV ACE_ROOT /opt/ACE_TAO/ACE
ENV TAO_ROOT /opt/ACE_TAO/TAO
ENV LD_LIBRARY_PATH /opt/ACE_TAO/ACE/lib

COPY config.h ${ACE_ROOT}/ace/config.h
COPY platform_macros.GNU ${ACE_ROOT}/include/makeinclude/platform_macros.GNU
COPY default.features ${ACE_ROOT}/bin/MakeProjectCreator/config/default.features

RUN ${ACE_ROOT}/bin/mwc.pl -type gnuace ${TAO_ROOT}/TAO_ACE.mwc
RUN cd ${TAO_ROOT}; make -s depend && make

ENV DDS_ROOT /opt/OpenDDS
ENV LD_LIBRARY_PATH ${ACE_ROOT}/lib:${DDS_ROOT}/lib
ENV QTDIR /usr
ENV QT4_INCDIR=/usr/include/qt4

CMD /opt/autobuild/autobuild.pl /opt/workspace/config.xml
WORKDIR /opt/workspace
