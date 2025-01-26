#!/bin/bash

echo "COMPOSE"
echo

declare -r service_list="$(ls ./services)"
declare compose_file=""

for service in ${service_list}
do
  compose_file="${compose_file}./services/${service}/docker-compose.yml:"
done

export COMPOSE_FILE="${compose_file%:}"

echo $COMPOSE_FILE