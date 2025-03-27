#!/bin/bash

[ -f "./secrets.env" ] && source ./secrets.env 

if [ ! -z "${INFISICAL_PROJECT_ID}" -a ! -z "${INFISICAL_CLIENT_ID}" -a ! -z "${INFISICAL_CLIENT_SECRET}" ]; then
    export INFISICAL_TOKEN="$(infisical login --method=universal-auth --client-id=${INFISICAL_CLIENT_ID} --client-secret=${INFISICAL_CLIENT_SECRET} --silent --plain)"
    alias infisicalw="infisical --projectId=${INFISICAL_PROJECT_ID} --token=${INFISICAL_TOKEN}"
fi