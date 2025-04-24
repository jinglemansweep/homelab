#!/bin/bash

echo "================"
echo "LAB ORCHESTRATOR"
echo "================"
echo

# Setup

export TEMP_PATH="/tmp/homelab"
mkdir -p "${TEMP_PATH}"

# Environment

source "${LAB_PATH}/scripts/setenv.sh" "${ENV_PATH}"
echo

# Secrets

if [ -n "${SECRET_HELPER}" ]; then
  echo "Using secret helper: ${SECRET_HELPER}"
  if [ -f "${LAB_PATH}/scripts/secrets/${SECRET_HELPER}.sh" ]; then
    source "${LAB_PATH}/scripts/secrets/${SECRET_HELPER}.sh"
    echo "Secrets loaded"
  else
    echo "Secret helper not found"
  fi
fi

if [ -f "${TEMP_PATH}/secrets.env" ]; then
  source "${TEMP_PATH}/secrets.env"
fi

# Cleanup

rm -rf "${TEMP_PATH}"

# Functions

function terraform_init() {
  pushd "${LAB_PATH}/terraform" >/dev/null
  echo "Terraform: Initializing"
  terraform init
  popd >/dev/null
}

# Arg Parsing

declare -r command="${1:-shell}"
shift 1

echo "Arguments: ${command} ${@}"

if [ "${command}" == "shell" ]; then
  echo "[shell]"
  echo
  exec "/bin/bash"
elif [ "${command}" == "terraform" ]; then
  echo "[terraform] ${1}"
  echo
  terraform_init
  exec terraform -chdir="${LAB_PATH}/terraform" ${1} -var-file "${TF_VAR_FILE}"
else
  echo "[exec] ${command} ${@}"
  echo
  exec "${command}" ${@}
fi

