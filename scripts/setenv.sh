#!/bin/bash

declare -r script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source "${script_dir}/_common.sh"

# Environment

export ANSIBLE_PRIVATE_KEY_FILE="${TEMP_PATH}/ssh/ansible.key"
export ANSIBLE_INVENTORY="${ENV_PATH}/ansible/inventory.yml"
export ANSIBLE_PLAYBOOK_DIR="${ENV_PATH}/ansible/playbooks"
export ANSIBLE_ROLES_PATH="${LAB_PATH}/ansible/roles:${LAB_PATH}/ansible/galaxy"
export ANSIBLE_REMOTE_USER="automation"
export TF_VAR_FILE="${ENV_PATH}/terraform/terraform.tfvars"

# Functions

function terraform_init() {
    pushd "${LAB_PATH}/terraform" >/dev/null
    echo "Terraform: Initializing"
    terraform init
    popd >/dev/null
}

# Process Environment

if [ -d "${ENV_PATH}" ]; then

    echo "Environment: ${ENV_PATH}"

    # Environment

    for i in "${ENV_PATH}/env"/*; do
        if [ -f "${i}" ]; then
            echo "Sourcing: ${i}"
            source "${i}"
        fi
    done

    # Secrets

    if [ -n "${SECRET_HELPER}" ]; then
        if [ -f "${LAB_PATH}/scripts/secrets/${SECRET_HELPER}.sh" ]; then
            echo "Secret Helper: ${SECRET_HELPER}"
            echo "export SECRET_HELPER=${SECRET_HELPER}" > ${TEMP_PATH}/secrets.env
            source "${LAB_PATH}/scripts/secrets/${SECRET_HELPER}.sh"
        else
            echo "WARNING: Secret helper not found"
        fi
    fi

    chmod -R 600 ${TEMP_PATH}/ssh/*.key

    if [ -f "${TEMP_PATH}/secrets.env" ]; then
        source "${TEMP_PATH}/secrets.env"
    fi

else

    echo "Environment not found!"

fi
