# Ansible

## Ansible Pull

Provision new devices quickly by pulling and running playbooks directly from source control.

#### Install

    apt install ansible git

#### Usage

    export PULL_HOME="/opt/ansible-pull"
    sudo ansible-pull -c local -d ${PULL_HOME} -U https://github.com/jinglemansweep/homelab.git ./ansible/setup.yml -i localhost, --extra-vars pull_home=${PULL_HOME}

#### Testing

Build test Docker container:

    cd ansible
    docker compose up

Test playbooks locally:

    ansible-playbook -c local -i localhost, <playbook>.yml --extra-vars pull_home=/opt/ansible-pull


