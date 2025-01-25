ARG image="debian"
ARG tag="bookworm"

FROM ${image}:${tag}

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update -y && \
    apt-get install -y ansible git sudo

ENV NEW_USER="user"
ENV ANSIBLE_PULL_HOME="/opt/ansible-pull"
ENV ANSIBLE_PULL_REPO="https://github.com/jinglemansweep/homelab.git"
ENV ANSIBLE_PULL_PLAYBOOK="./ansible/playbooks/pull-test.yml"
ENV ANSIBLE_PULL_HOSTNAME="localhost"

ADD ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/bin/bash", "/docker-entrypoint.sh"]
