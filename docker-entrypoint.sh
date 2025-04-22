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

pushd "${LAB_PATH}/terraform" >/dev/null
echo "Terraform: Initializing"
terraform init
popd >/dev/null

# Run the command passed to the container
exec "$@"
