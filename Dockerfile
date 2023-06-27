#----------------------------------- #
# Use for Intel or AMD processors
# github: seasketch/docker-gp-workspace
# docker: seasketch/geoprocessing-workspace
#----------------------------------- #
ARG VARIANT="jammy"
FROM mcr.microsoft.com/devcontainers/base:${VARIANT}

# Switch to built-in non-root gp user with sudo capabilities
USER vscode

# Install common dependencies
RUN sudo apt-get update && sudo apt-get -y upgrade \
  && sudo apt-get install -y --no-install-recommends \
    postgresql-client \
    openjdk-17-jdk \
    git \
    wget \
    g++ \
    ca-certificates \
    curl \
    && sudo rm -rf /var/lib/apt/lists/*

# Install nvm to user directory - based on https://github.com/nvm-sh/nvm and https://github.com/nvm-sh/nvm/blob/master/Dockerfile
ENV NODE_VERSION v16.16.0
RUN mkdir -p /home/vscode/.nvm/
RUN chown vscode:vscode -R "$HOME/.nvm"
RUN echo 'export NVM_DIR="/home/vscode/.nvm"'                                       >> "$HOME/.bashrc"
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> "$HOME/.bashrc"
RUN echo '[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> "$HOME/.bashrc"
RUN cd ~
RUN sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Install platform specific dependencies
COPY installer/ /installer
RUN sudo chmod -R 755 /installer

# Setup miniconda path
ENV PATH="~/miniconda3/bin:${PATH}"
ARG PATH="~/miniconda3/bin:${PATH}"

# Run target specific tasks
ARG TARGETPLATFORM
RUN /bin/bash -c "source /installer/$TARGETPLATFORM.sh"
