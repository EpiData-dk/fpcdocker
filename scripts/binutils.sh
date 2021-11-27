#!/bin/bash

# Setup
BINUTILS_NAME="binutils-$BINUTILS_VERSION"
source ${EXPORTS_FILE}

# Prepare
mkdir -p "$BUILD_DIR/binutils"
pushd "$BUILD_DIR/binutils" || exit 1

# Get and extract
wget "https://ftp.gnu.org/gnu/binutils/$BINUTILS_NAME.tar.xz"
xz -d "$BINUTILS_NAME.tar.xz"
tar xf "$BINUTILS_NAME.tar"

pushd "$BINUTILS_NAME" || exit

TARGET="x86_64-apple-darwin"
./configure \
        --prefix=/usr \
        --target=${TARGET} \
        --infodir=/usr/share/info/${TARGET} \
        --enable-lto --enable-plugins \
        --enable-64-bit-bfd \
        --disable-multilib --disable-nls \
        --disable-werror

# build
make 

# install into destination for building docker image
make DESTDIR=${INSTALL_DST} install
echo "PATH=$PATH:${INSTALL_DST}/usr/bin" >> ${EXPORTS_FILE}
