#!/bin/bash

source ${EXPORTS_FILE}

CPU=$1; shift
OS=$1; shift

pushd ${BUILD_DIR}/fpc || exit

make distclean crossall crossinstall OPT="-O2 -XX -CX -Xs" CPU_TARGET="$CPU" OS_TARGET="$OS" PP="$FPC_COMPILER" INSTALL_PREFIX="$INSTALL_DST/fpc" "$@"
RESULT=$?

popd || exit

exit $RESULT