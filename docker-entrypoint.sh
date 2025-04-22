#!/bin/bash

# Infisical
export INFISICAL_TOKEN="$(infisical login --method=universal-auth --client-id=${INFISICAL_UNIVERSAL_AUTH_CLIENT_ID} --client-secret=${INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET} --silent --plain)"
    
# Terraform
export TF_VAR_infisical_workspace_id="${INFISICAL_PROJECT_ID}"

# Run the command passed to the container
exec infisical --projectId=${INFISICAL_PROJECT_ID} --token=${INFISICAL_TOKEN} run -- "$@"
