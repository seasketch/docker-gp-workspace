#!/usr/bin/env sh

# Put installer in current user home directory, install to home directory, add to user bash config, and remove installer
mkdir -p ~/miniconda \
    && cd ~/miniconda \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.3.1-0-Linux-aarch64.sh \
    && mkdir ~/.conda \
    && chmod 755 Miniconda3-py38_23.3.1-0-Linux-aarch64.sh \
    && bash Miniconda3-py38_23.3.1-0-Linux-aarch64.sh -b -p /home/vscode/miniconda3 \
    && echo "Running $(conda --version)" && \
    conda init bash && \
    . /home/vscode/.bashrc && \
    conda update conda && \
    conda install python=3.8 pip && \
    conda install -c conda-forge gdal=3.3.1 && \
    cd ~ && \
    rm -rf ~/miniconda

    mkdir -p ~/awscli \
    && cd ~/awscli \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf ~/awscli