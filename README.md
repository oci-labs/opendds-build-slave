OpenDDS Pull Request Builder
============================

Build a Docker image that can then be used to build OpenDDS.

To build the image:

    $ git clone https://github.com/jrw972/opendds-pr-builder.git
    $ cd opendds-pr-builder
    $ git clone --depth 1 https://github.com/DOCGroup/autobuild.git
    $ git clone --depth 1 https://github.com/DOCGroup/MPC.git
    $ git clone --depth 1 https://github.com/DOCGroup/ATCD.git
    $ docker build -t opendds-pr-builder .

To build OpenDDS with the image:

    $ git clone --depth 1 https://github.com/objectcomputing/OpenDDS.git
    $ docker run --rm -v "$PWD/workspace:/opt/workspace" -v "$PWD/OpenDDS:/opt/OpenDDS" opendds-pr-builder
