# Ansible

## Ansible Pull

Provision new devices quickly by pulling and running playbooks directly from source control.

#### Install

    apt install ansible git

#### Usage

    ansible-pull -U https://github.com/jinglemansweep/homelab.git ./ansible/pull-test.yml -i "${HOSTNAME}," --extra-vars "ansible_connection=local" -v
