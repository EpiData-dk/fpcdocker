#!/bin/bash

source ${EXPORTS_FILE}

# Setup
SDK_VERSION=10.15
SDK_NAME=MacOSX$SDK_VERSION.sdk
SDK_NAME_XZ=$SDK_NAME.tar.xz

# Prepare / Downloads
pushd "${BUILD_DIR}" || exit

# Checkout OSXcross
git clone https://github.com/tpoechtrager/osxcross.git


# Checkout SDK and prepare for OSXcross
git clone https://github.com/phracker/MacOSX-SDKs.git
pushd "MacOSX-SDKs" || exit
mkdir -p "$SDK_NAME/usr/include/c++/v1/"
cp -r /usr/include/c++/11.1.0/* "$SDK_NAME/usr/include/c++/v1/"
tar -c -I 'xz -9 -T0' -f "$SDK_NAME_XZ" "$SDK_NAME"
popd || exit

mv MacOSX-SDKs/$SDK_NAME_XZ osxcross/tarballs/


# Work on OSXCross
pushd "osxcross" || exit

UNATTENDED=yes OSX_VERSION_MIN=10.13 ./build.sh

if [[ ! -f "target/bin/x86_64-apple-darwin19-ld" ]] ; then
    exit 1
fi

# Install in local folder
# OSXCROSS_DIR=${BUILD_DIR}/opt/osxcross/
# mkdir -p ${OSXCROSS_DIR}
# cp -r target/* ${OSXCROSS_DIR}

# Copy to output
OSXCROSS_DIR=${INSTALL_DST}/opt/osxcross/
mkdir -p "${OSXCROSS_DIR}"
cp -r target/* "${OSXCROSS_DIR}"

# osxcross
popd || exit

# "$BUILD_DIR"
popd || exit

## config and settings
mkdir -p "${INSTALL_DST}/etc/ld.so.conf.d"
cp "config/osxcross.ld.conf" "${INSTALL_DST}/etc/ld.so.conf.d/"
echo "OSXCROSS_DIR=${OSXCROSS_DIR}"
echo "PATH=$PATH:${OSXCROSS_DIR}/bin" >> ${EXPORTS_FILE}