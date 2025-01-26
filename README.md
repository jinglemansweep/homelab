# Homelab

## Quick Start

From a fresh Debian device, install core dependencies and setup user permissions:

    export default_user="user"
    apt update && apt install git gnupg sudo
    usermod -aG sudo ${default_user}

Install Ansible using [official instructions](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian):

    wget -O- "https://keyserver.ubuntu.com/pks/lookup?fingerprint=on&op=get&search=0x6125E2A8C77F2818FB7BD15B93C4A3FD7BB9C367" | sudo gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
    
    echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu jammy main" | sudo tee /etc/apt/sources.list.d/ansible.list
    
    sudo apt update && sudo apt install ansible

To continue installing and configuring required packages, see [Ansible Pull](./ansible/readme.md) documentation.

