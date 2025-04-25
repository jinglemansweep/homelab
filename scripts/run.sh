#!/bin/bash

source "${LAB_PATH}/scripts/setenv.sh"

header "Homelab Runner"
echo

# Arg Parsing

declare -r command="${1:-shell}"
shift 1

echo "Arguments: ${command} ${@}"
echo

if [ "${command}" == "shell" ]; then
  subheader "Shell"
  echo
  exec "/bin/bash"
elif [ "${command}" == "terraform" ]; then
  subheader "Terraform"
  echo "Args: ${@}"
  echo
  terraform_init
  exec terraform -chdir="${LAB_PATH}/terraform" ${1} -var-file "${TF_VAR_FILE}"
elif [ "${command}" == "ansible-playbook" ]; then
  subheader "Ansible Playbook"
  echo "Args: ${@}"
  echo
  ansible_init
  cd "${ENV_PATH}/ansible"
  exec ansible-playbook ${@}
else
  echo "[exec] ${command} ${@}"
  echo
  exec "${command}" ${@}
fi

