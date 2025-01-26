# Ansible Pull

Provision new devices quickly by pulling and running playbooks directly from source control. Once provisioned, devices will check for updates and apply them automatically.

### Usage

    sudo ansible-pull -c local -d /opt/ansible-pull -U https://github.com/jinglemansweep/homelab.git ./ansible/setup.yml -i localhost, -e pull_home=/opt/ansible-pull

### Testing

Build test Docker container:

    cd ansible
    docker compose up
