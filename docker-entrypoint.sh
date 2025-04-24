#!/bin/bash

echo "=========="
echo "LAB RUNNER"
echo "=========="
echo

exec "${LAB_PATH}/scripts/run.sh" $@
