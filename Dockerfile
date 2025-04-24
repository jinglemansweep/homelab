ARG base_image="debian"
ARG base_image_suffix="-slim"
ARG arch="amd64"
ARG debian_release="bookworm"

FROM ${base_image}:${debian_release}${base_image_suffix} AS build

# Config
ARG arch
ARG debian_release
ENV LAB_PATH="/opt/lab"
ENV ENV_PATH="/work/env"
ENV SECRET_HELPER="default"

# System Packages
RUN apt-get -y update && \
    apt-get -y install curl python3-pip python3-venv wget

# Filesystem
RUN mkdir -p /tmp/build

# Python
RUN python3 -m venv /opt/venv && \
    /opt/venv/bin/pip install --upgrade pip poetry uv
ENV PATH="/opt/venv/bin:${PATH}"

# Ansible
RUN /opt/venv/bin/pip install ansible

# Docker
RUN wget -O /etc/apt/keyrings/docker.asc https://download.docker.com/linux/debian/gpg && \
    echo "deb [arch=${arch} signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian ${debian_release} stable" | tee /etc/apt/sources.list.d/docker.list && \
    apt-get -y update && \
    apt-get -y install docker-ce-cli docker-compose-plugin

# Terraform
RUN wget -O - https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [arch=${arch} signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com ${debian_release} main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get -y update && \
    apt-get -y install terraform

# Infisical
RUN wget -O /tmp/build/infisical.sh https://artifacts-cli.infisical.com/setup.deb.sh && \
    bash /tmp/build/infisical.sh && \
    apt-get -y install infisical

# Cleanup
RUN apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* /tmp/build

# Copy Resources
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
COPY ./ansible ${LAB_PATH}/ansible
COPY ./terraform ${LAB_PATH}/terraform
COPY ./compose ${LAB_PATH}/compose
COPY ./scripts ${LAB_PATH}/scripts

# Setup

ENV ANSIBLE_ROLES_PATH="${LAB_PATH}/ansible/roles"
ENV ANSIBLE_CONFIG="${LAB_PATH}/ansible/ansible.cfg"
ENV ANSIBLE_ROLES_PATH="${LAB_PATH}/ansible/galaxy"
ENV ANSIBLE_HOST_KEY_CHECKING="false"
RUN cd ${LAB_PATH}/ansible && \
    ansible-galaxy install -r requirements.yml -p "${LAB_PATH}/ansible/galaxy"

# Container
WORKDIR /opt/lab

# Entrypoint
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
CMD ["/bin/bash"]
