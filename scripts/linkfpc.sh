#!/bin/bash

source ${EXPORTS_FILE}

pushd "${INSTALL_DST}/fpc/bin" || exit

ln -s "../lib/fpc/${TARGET_FPC_VERSION}/ppcross386" .
ln -s "../lib/fpc/${TARGET_FPC_VERSION}/ppcrossx64" .
ln -s "../lib/fpc/${TARGET_FPC_VERSION}/ppcx64" .

popd || exit