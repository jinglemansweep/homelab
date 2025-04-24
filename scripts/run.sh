#!/bin/bash

source "${LAB_PATH}/scripts/setenv.sh"

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
elif [ "${command}" == "ansible-playbook" ]; then
  echo "[ansible-playbook] ${@}"
  echo
  ansible_init
  cd "${ENV_PATH}/ansible"
  exec ansible-playbook ${@}
else
  echo "[exec] ${command} ${@}"
  echo
  exec "${command}" ${@}
fi

