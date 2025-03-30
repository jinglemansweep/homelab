#!/bin/bash

[ -f "./secrets.env" ] && source ./secrets.env 

if [ ! -z "${INFISICAL_PROJECT_ID}" -a ! -z "${INFISICAL_UNIVERSAL_AUTH_CLIENT_ID}" -a ! -z "${INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET}" ]; then
    export INFISICAL_TOKEN="$(infisical login --method=universal-auth --client-id=${INFISICAL_UNIVERSAL_AUTH_CLIENT_ID} --client-secret=${INFISICAL_UNIVERSAL_AUTH_CLIENT_SECRET} --silent --plain)"
    export TF_VAR_infisical_workspace_id="${INFISICAL_PROJECT_ID}"
    alias infisicalw="infisical --projectId=${INFISICAL_PROJECT_ID} --token=${INFISICAL_TOKEN}"
fi