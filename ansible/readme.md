# Ansible

## Ansible Pull

Provision new devices quickly by pulling and running playbooks directly from source control.

### Usage

    sudo ansible-pull -c local -d /opt/ansible-pull -U https://github.com/jinglemansweep/homelab.git ./ansible/setup.yml -i localhost, -e pull_home=/opt/ansible-pull

### Testing

Build test Docker container:

    cd ansible
    docker compose up

Test playbooks locally:

    ansible-playbook -c local -i localhost, <playbook>.yml -e pull_home=/opt/ansible-pull


