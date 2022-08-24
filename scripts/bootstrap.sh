#!/bin/bash

source ${EXPORTS_FILE}

BOOTSTRAP_NAME="fpc-$BOOTSTRAP_VERSION.x86_64-linux"
NEW_VERSION=$(echo "$TARGET_FPC_VERSION" | tr "." _)
echo "New Version: $NEW_VERSION"

pushd ${BUILD_DIR} || exit 1

mkdir -p download
pushd download/ || exit
wget "https://sourceforge.net/projects/freepascal/files/Linux/$BOOTSTRAP_VERSION/$BOOTSTRAP_NAME.tar/download" -O "$BOOTSTRAP_NAME.tar"
tar -xf $BOOTSTRAP_NAME.tar

pushd $BOOTSTRAP_NAME || exit

tar -xf "binary.x86_64-linux.tar"
tar -zxf "base.x86_64-linux.tar.gz"

BOOTSTRAP_FPC="$(pwd)/lib/fpc/$BOOTSTRAP_VERSION/ppcx64"

popd || exit
popd || exit

if [[ -d "fpc" ]] ; then
    rm -fr "fpc"
fi

RELEASE="release_$NEW_VERSION"
wget "https://gitlab.com/freepascal.org/fpc/source/-/archive/$RELEASE/source-$RELEASE.tar.gz"
tar -zxf "source-$RELEASE.tar.gz"
mv "source-$RELEASE" "fpc"

pushd fpc || exit

make clean all install OPT="-O2 -XX -CX -Xs" PP="$BOOTSTRAP_FPC" INSTALL_PREFIX="$INSTALL_DST/fpc"
RESULT=$?

popd || exit  # fpc
popd || exit  # ${BUILD_DIR}

FPC_COMPILER="$INSTALL_DST/fpc/lib/fpc/$TARGET_FPC_VERSION/ppcx64"

echo "FPC_COMPILER=$FPC_COMPILER" >> ${EXPORTS_FILE}

exit $RESULT