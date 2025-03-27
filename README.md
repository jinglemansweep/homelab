# Homelab

[![Infisical Secrets](https://github.com/jinglemansweep/homelab/actions/workflows/infisical.yml/badge.svg)](https://github.com/jinglemansweep/homelab/actions/workflows/infisical.yml)

## Quick Start

### Install Dependencies

From a fresh Debian device, install core dependencies and setup user permissions:

    export default_user="user"
    apt update && apt install git gnupg sudo
    usermod -aG sudo ${default_user}

Install Ansible using [official instructions](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian):

    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/ansible.list
    sudo apt update && sudo apt install ansible

### Ansible Pull

Ansible Pull is used to provision devices in a stateless manner. This means that the device will be provisioned from source control and will automatically update itself when changes are made to the source control repository.

Run the following as `root`:

    ANSIBLE_PULL_REPO="https://github.com/jinglemansweep/homelab.git"
    ANSIBLE_PULL_HOME="/opt/ansible-pull"
    ansible-pull -c local -d ${ANSIBLE_PULL_HOME} -U ${ANSIBLE_PULL_REPO} ./ansible/setup.yml -i localhost, -e ansible_pull_repo=${ANSIBLE_PULL_REPO} -e ansible_pull_home=${ANSIBLE_PULL_HOME}

Once provisioned, a [helper script](./ansible/scripts/pull.sh) is installed in `/opt/ansible-pull/scripts/pull.sh` which can be invoked to update the device. By default, a systemd service (`ansible-pull.service`) and timer (`ansible-pull.timer`) are installed to automatically update the device daily.

