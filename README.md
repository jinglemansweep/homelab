# Homelab

## Ansible

### Bootstrap Device

Bootstrapping a new device creates a system user for Ansible to use and sets up SSH keys for authentication.

    ansible-playbook \
        -i <HOSTNAME>, \
        -u <USER> \
        --ask-pass --ask-become-pass \
        ./playbooks/bootstrap.yml
