#!/bin/bash

## Requirements:
# subversion wget git clang cmake python 

## Setup Parameters
export BOOTSTRAP_VERSION='3.2.0'
export TARGET_FPC_VERSION='3.2.2'
export BINUTILS_VERSION='2.37'

export BUILD_DIR="$(pwd)/build/"
export EXPORTS_FILE="${BUILD_DIR}/exports"


DOCKER_HUB_NAME='epidata/fpcbuild'


scripts/setup.sh || exit 1
scripts/binutils.sh || exit 1
scripts/osxcross.sh || exit 1

scripts/bootstrap.sh || exit 1
scripts/crossbuild.sh i386 linux || exit 1
scripts/crossbuild.sh x86_64 win64 || exit 1
scripts/crossbuild.sh i386 win32 || exit 1

source ${EXPORTS_FILE}
scripts/crossbuild.sh x86_64 darwin CROSSOPT="-XR${OSXCROSS_DIR}/SDK/MacOSX10.15.sdk" BINUTILSPREFIX=x86_64-apple-darwin19- || exit 1
scripts/linkfpc.sh || exit 1

# docker build -t "${DOCKER_HUB_NAME}" docker_context
# docker push -t "${DOCKER_HUB_NAME}:${TARGET_FPC_VERSION}"
# docker push -t "${DOCKER_HUB_NAME}:latest"