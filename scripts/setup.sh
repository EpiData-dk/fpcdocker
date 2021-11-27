#!/bin/bash

INSTALL_DST="$(pwd)/docker_context/output/"

clean_and_create_dir() {
    if [[ -d "$1" ]]; then
        rm -fr "$1"
    fi
    mkdir -p "$1"
}

clean_and_create_dir $INSTALL_DST
clean_and_create_dir $BUILD_DIR

echo "INSTALL_DST=$INSTALL_DST" > ${EXPORTS_FILE}
echo "BUILD_DIR=$BUILD_DIR" >> ${EXPORTS_FILE}

mkdir -p "$INSTALL_DST/etc/"

cp "config/fpc.cfg" "$INSTALL_DST/etc/"