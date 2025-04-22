ARG base_image="debian"
ARG base_image_suffix="-slim"
ARG arch="amd64"
ARG debian_release="bookworm"

FROM ${base_image}:${debian_release}${base_image_suffix} AS build

ARG arch
ARG debian_release

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
    apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

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
COPY ./ansible /work/ansible
COPY ./terraform /work/terraform
COPY ./compose /work/compose
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

# Entrypoint
ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
CMD ["/bin/bash"]
