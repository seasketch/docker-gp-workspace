#!/usr/bin/env sh

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-aarch64.sh -b \
    && rm -f Miniconda3-latest-Linux-aarch64.sh \
    && echo "Running $(conda --version)" && \
    conda init bash && \
    . /root/.bashrc && \
    conda update conda && \
    conda install python=3.8 pip && \
    conda install -c conda-forge gdal=3.3.1