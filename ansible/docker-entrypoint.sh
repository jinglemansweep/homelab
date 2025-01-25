#!/bin/bash

echo "Ansible Pull Test"
echo
echo "Home:      ${ANSIBLE_PULL_HOME}"
echo "Repo:      ${ANSIBLE_PULL_REPO}"
echo "Playbook:  ${ANSIBLE_PULL_PLAYBOOK}"
echo

ansible-pull -v \
  -d ${ANSIBLE_PULL_HOME} \
  -U ${ANSIBLE_PULL_REPO} \
  ${ANSIBLE_PULL_PLAYBOOK} \
  -i "localhost," \
  --extra-vars pull_home=${ANSIBLE_PULL_HOME}

# exit 0

echo
echo "Debug"
echo
echo "/opt/ansible-pull:"
ls -l /opt/ansible-pull
echo
echo "/opt/ansible-pull/ansible:"
ls -l /opt/ansible-pull/ansible
echo
