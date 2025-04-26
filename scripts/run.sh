#!/bin/bash

declare -r script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
source "${script_dir}/_common.sh"
source "${script_dir}/setenv.sh"

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

  cd "${ENV_PATH}/ansible"
  exec ansible-playbook ${@}

elif [ "${command}" == "compose" ]; then

  subheader "Docker Compose"
  declare -r stack="${1}"
  shift 1

  echo "Stack: ${stack}"
  echo "Args: ${@}"
  echo

  declare -r stack_env_file="${ENV_PATH}/compose/stacks/${stack}.sh"

  if [ -f "${stack_env_file}" ]; then
    echo "Sourcing stack '${stack_env_file}'"
    source "${stack_env_file}"
    if [ -n "${COMPOSE_DOCKER_CONTEXT}" ]; then
      if [ "${COMPOSE_DOCKER_CONTEXT}" != "$(docker context show)" ]; then
        echo "Error: Expected Docker Context '${COMPOSE_DOCKER_CONTEXT}'"
        exit 1
      fi
    else
      echo "Error: No Docker Context supplied"
      exit 1
    fi
  else
    echo "Error: Compose stack '${stack}' not found"
    exit 1
  fi

  echo "$COMPOSE_FILE"
  docker context show
  exec docker compose ${@}

else

  subheader "Exec"
  echo "Args: ${@}"
  echo

  exec "${command}" ${@}

fi
