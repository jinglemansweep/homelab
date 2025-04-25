#!/bin/bash

if [ -n "${ENV_PATH}" ]; then
    export LAB_PATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../" &> /dev/null && pwd)"
    export TEMP_PATH="/tmp/homelab"
    mkdir -p "${TEMP_PATH}" "${TEMP_PATH}/ssh"
else
    echo "ERROR: 'ENV_PATH' environment variable not set!"
fi

function header() {
    figlet "${1}"
}

function subheader() {
    figlet -f "/usr/share/figlet/small.flf" "${1}"
}
