OpenDDS Build Slave
===================

Build a Docker image that can then be used to build OpenDDS.

To build the image:

    $ git clone https://github.com/oci-labs/opendds-build-slave.git
    $ cd opendds-build-slave
    $ git clone --depth 1 https://github.com/DOCGroup/autobuild.git
    $ git clone --depth 1 https://github.com/DOCGroup/MPC.git
    $ git clone --depth 1 --single-branch --branch Latest_Beta https://github.com/DOCGroup/ACE_TAO.git
    $ docker build -t opendds-build-slave .

To build OpenDDS with the image:

    $ git clone --depth 1 https://github.com/objectcomputing/OpenDDS.git
    $ docker run --rm -v "$PWD/workspace:/opt/workspace" -v "$PWD/OpenDDS:/opt/OpenDDS" opendds-build-slave
