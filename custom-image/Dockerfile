FROM hashicorp/consul:1.10.0-beta2

# Metadata params
ARG BUILD_DATE
ARG ANSIBLE_VERSION
ARG ANSIBLE_LINT_VERSION
ARG MITOGEN_VERSION


# Metadata
LABEL maintainer="Firas Chbiki <chb.firas@gmail.com>" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.version=${ANSIBLE_VERSION} \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.description="Ansible on alpine docker image" \
      org.label-schema.schema-version="1.0"

RUN set -ex && apk --update --no-cache add \
        add sudo \
        ca-certificates \
        git nano \
        openssh-client \
        openssl \
        python3\
        py3-pip \
        py3-cryptography \
        rsync \
        sshpass

RUN apk --update add --virtual \
        .build-deps \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base \
        curl \
 && curl -s -L https://networkgenomics.com/try/mitogen-${MITOGEN_VERSION}.tar.gz | tar xzf - -C /opt/ \
 && mv /opt/mitogen-* /opt/mitogen \
 && pip3 install --upgrade \
        pip \
        cffi \
 && pip3 install \
        ansible==${ANSIBLE_VERSION} \
        ansible-lint==${ANSIBLE_LINT_VERSION} \
 && apk del \
        .build-deps \
 && rm -rf /var/cache/apk/*

RUN mkdir -p /etc/ansible \
 && echo 'localhost' > /etc/ansible/hosts \
 && echo -e """\
\n\
Host *\n\
    StrictHostKeyChecking no\n\
    UserKnownHostsFile=/dev/null\n\
""" >> /etc/ssh/ssh_config  \
&& echo root:rootpass | chpasswd && echo consul:consulpass | chpasswd

COPY ansible.cfg /etc/ansible/ansible.cfg


WORKDIR /ansible
COPY entrypoint entrypoint 
RUN chmod +x entrypoint && ./entrypoint && rm entrypoint && chown -R consul:consul /ansible

RUN git
USER root

