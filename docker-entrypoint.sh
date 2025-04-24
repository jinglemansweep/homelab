#!/bin/bash

echo "================"
echo "LAB ORCHESTRATOR"
echo "================"
echo

# Environment

source "${LAB_PATH}/scripts/setenv.sh" "${PWD}" "${ENV_PATH}"

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
echo

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

