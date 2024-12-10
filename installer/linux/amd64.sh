#!/usr/bin/env sh

# Put installer in current user home directory, install to home directory, add to user bash config, and remove installer
mkdir -p ~/miniconda \
    && cd ~/miniconda \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-py312_24.7.1-0-Linux-x86_64.sh \
    && mkdir ~/.conda \
    && chmod 755 Miniconda3-py312_24.7.1-0-Linux-x86_64.sh \
    && bash Miniconda3-py312_24.7.1-0-Linux-x86_64.sh -b -p /home/vscode/miniconda3 \
    && echo "Running $(conda --version)" && \
    conda init bash && \
    . /home/vscode/.bashrc && \
    conda update conda && \
    conda install --solver=classic conda-forge::conda-libmamba-solver conda-forge::libmamba conda-forge::libmambapy conda-forge::libarchive && \
    conda install python pip && \
    conda install -c conda-forge gdal && \
    cd ~ && \
    rm -rf ~/miniconda

    mkdir -p ~/awscli \
    && cd ~/awscli \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && sudo ./aws/install \
    && rm -rf ~/awscli

# miniconda pinned to py312_24.7.1-0-Linux-x86_64 due to sqlite shared library not found error
# conda-libmamba-solver workaround due to error - https://stackoverflow.com/a/78293971