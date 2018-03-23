#!/bin/bash

SERVER_IF="enp6s0"
SERVER_IP=$(ip a | grep inet | grep $SERVER_IF | cut -d ' ' -f 6 | cut -d '/' -f 1)
SERVER_PORT=1234

TEMP_DIR=$(mktemp -d --suffix=QRT)

if [ $# -ne 0 ]; then
    if [ ! -f "$1" ]; then
        echo "No file"
    else
        ln -f "$1" "${TEMP_DIR}/${1}"
        FILE="http://${SERVER_IP}:${SERVER_PORT}/${1}"
        qrencode -m 2 -t ANSI $FILE
        pushd $TEMP_DIR
        python3 -m http.server $SERVER_PORT
        popd
                
    fi
fi

rm -rf $TEMP_DIR