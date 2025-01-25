# Ansible

## Ansible Pull

Provision new devices quickly by pulling and running playbooks directly from source control.

#### Install

    apt install ansible git

#### Usage

    ansible-pull -K -v -c local -U https://github.com/jinglemansweep/homelab.git ./ansible/pull-test.yml -i localhost, --extra-vars pull_home=/opt/ansible-pull

#### Testing

Build test Docker container:

    cd ansible
    docker compose up

Test playbooks locally:

    ansible-playbook -c local -i localhost, <playbook>.yml --extra-vars pull_home=/opt/ansible-pull


