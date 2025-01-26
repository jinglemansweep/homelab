#!/bin/bash

[ -f /etc/default/ansible-pull ] && . /etc/default/ansible-pull

[ -z "${ANSIBLE_PULL_HOME}" ] && echo "ANSIBLE_PULL_HOME not set" && exit 1
[ -z "${ANSIBLE_PULL_REPO}" ] && echo "ANSIBLE_PULL_REPO not set" && exit 1

declare -r ANSIBLE_PULL_PLAYBOOK="${1:-update.yml}"

echo "ANSIBLE PULL"
echo
echo "Home:     ${ANSIBLE_PULL_HOME}"
echo "Repo:     ${ANSIBLE_PULL_REPO}"
echo "Playbook: ${ANSIBLE_PULL_PLAYBOOK}"
echo

sudo ansible-pull -c local \
-d ${ANSIBLE_PULL_HOME} \
-U ${ANSIBLE_PULL_REPO} \
./ansible/${ANSIBLE_PULL_PLAYBOOK} \
-i localhost, \
-e ansible_pull_repo=${ANSIBLE_PULL_REPO} \
-e ansible_pull_home=${ANSIBLE_PULL_HOME}
