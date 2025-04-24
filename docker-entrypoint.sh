#!/bin/bash

echo "================"
echo "LAB ORCHESTRATOR"
echo "================"
echo

# Environment
source /opt/lab/scripts/setenv.sh "${ENV_PATH}"
echo

# Infisical
export INFISICAL_TOKEN="$(infisical login --method=universal-auth --client-id=${INFISICAL_UNIVERSAL_AUTH_CLIENT_ID} --client-secret=${INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET} --silent --plain)"
export TF_VAR_infisical_workspace_id="${INFISICAL_PROJECT_ID}"
infisical export --projectId=${INFISICAL_PROJECT_ID} --token=${INFISICAL_TOKEN} --format=dotenv-export > "${LAB_PATH}/secrets.env"

# Secrets
if [ -f "${LAB_PATH}/secrets.env" ]; then
  source "${LAB_PATH}/secrets.env"
fi

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

echo "Command: ${command}"
echo

if [ "${command}" == "shell" ]; then
  echo "Shell:"
  exec "/bin/bash"
elif [ "${command}" == "terraform" ]; then
  echo "Terraform: $1"
  terraform_init
  terraform -chdir="${LAB_PATH}/terraform" ${1} -var-file "${TF_VAR_FILE}"
else
  echo "Exec '${command}':"
  exec "${command}" $@
fi

