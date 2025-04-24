#!/bin/bash

export LAB_PATH="${1}"
export ENV_PATH="${2}"
export TEMP_PATH="/tmp/homelab"

# Filesystem

mkdir -p "${TEMP_PATH}"

# Environment

if [ -d "${ENV_PATH}" ]; then

    echo "Environment: ${ENV_PATH}"

    # Environment

    if [ -f "${ENV_PATH}/env.sh" ]; then
        echo "Sourcing: ${ENV_PATH}/env.sh"
        source "${ENV_PATH}/env.sh" 
        export ANSIBLE_INVENTORY_FILE="${ENV_PATH}/inventory"
        export TF_VAR_FILE="${ENV_PATH}/terraform.tfvars"
    fi

    # Secrets

    if [ -n "${SECRET_HELPER}" ]; then
        echo "Secret Helper: ${SECRET_HELPER}"
        echo "export LAB_SECRET_HELPER=${SECRET_HELPER}" > ${TEMP_PATH}/secrets.env
        if [ -f "${LAB_PATH}/scripts/secrets/${SECRET_HELPER}.sh" ]; then
            source "${LAB_PATH}/scripts/secrets/${SECRET_HELPER}.sh"
        else
            echo "WARNING: Secret helper not found"
        fi
    fi

    if [ -f "${TEMP_PATH}/secrets.env" ]; then
        source "${TEMP_PATH}/secrets.env"
    fi

    rm -rf "${TEMP_PATH}/secrets.env"

else
    
    echo "Environment not found!"

fi

