#----------------------------------- #
# Use for Intel or AMd processorts
# github: seasketch/docker-gp-workspace
# docker: seasketch/geoprocessing-workspace
#----------------------------------- #
ARG VARIANT="jammy"
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

RUN apt-get update && apt-get -y upgrade \
  && apt-get install -y --no-install-recommends \
    postgresql-client \
    openjdk-17-jdk \
    git \
    wget \
    g++ \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN touch /root/.bashrc

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION v16.16.0
ENV NPM_VERSION 8.11.0
RUN mkdir -p /usr/local/nvm && apt-get update && echo "y" | apt-get install curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION && npm install -g npm@$NPM_VERSION"
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH

# Install platform specific dependencies
COPY installer/ /installer
ARG TARGETPLATFORM
RUN /bin/bash -c "source /installer/$TARGETPLATFORM.sh"
