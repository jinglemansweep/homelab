#!/bin/bash

export INFISICAL_TOKEN="$(infisical login --method=universal-auth --client-id=${INFISICAL_UNIVERSAL_AUTH_CLIENT_ID} --client-secret=${INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET} --silent --plain)"
export TF_VAR_infisical_workspace_id="${INFISICAL_PROJECT_ID}"
infisical export --projectId=${INFISICAL_PROJECT_ID} --token=${INFISICAL_TOKEN} --format=dotenv-export >> "${TEMP_PATH}/secrets.env"
