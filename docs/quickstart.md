# Quick Start

From a fresh Debian device, install core dependencies and setup user permissions:

    export default_user="user"
    apt update && apt install ansible git sudo
    usermod -aG sudo ${default_user}

To continue installing and configuring required packages, see [Ansible Pull](../ansible/readme.md) documentation.
