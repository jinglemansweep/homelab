#!/bin/bash

export SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd)

declare env_path="${1:-${SCRIPT_DIR}/envs/default}"

if [ -d "${env_path}" ]; then

    echo "Environment: ${env_path}"

    # Environment
    if [ -f "${env_path}/env" ]; then
        echo "Sourcing: ${env_path}/env"
        source "${env_path}/env" 
        export INFISICAL_UNIVERSAL_AUTH_CLIENT_ID
        export INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET
        export INFISICAL_PROJECT_ID
        export ANSIBLE_INVENTORY_FILE="${env_path}/inventory"
        export TF_VAR_FILE="${env_pah}/tfvars"
    fi

    # Infisical
    if [ ! -z "${INFISICAL_PROJECT_ID}" -a ! -z "${INFISICAL_UNIVERSAL_AUTH_CLIENT_ID}" -a ! -z "${INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET}" ]; then
        echo "Login: Infisical"
        export INFISICAL_TOKEN="$(infisical login --method=universal-auth --client-id=${INFISICAL_UNIVERSAL_AUTH_CLIENT_ID} --client-secret=${INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET} --silent --plain)"
        alias lab_infisical="infisical --projectId=${INFISICAL_PROJECT_ID} --token=${INFISICAL_TOKEN}"
        export TF_VAR_infisical_workspace_id="${INFISICAL_PROJECT_ID}"
    else
        echo "Error: Missing required environment variables for Infisical login"
    fi

fi