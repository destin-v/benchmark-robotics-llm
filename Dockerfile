#===================================================
# Docker template with Micromamba (with GPU)
# 
# Build: (one-line)
# >>> podman build --format docker -t <IMAGE NAME> <DOCKERFILE_PATH>
#
# Run: (multi-line)
# >>> podman run -it --rm \
#   --env OPENAI_API_KEY \
#   --env OPENAI_ENDPOINT \
#   -v outputs:/root/benchmark-robotics-llm/outputs \
#   --device nvidia.com/gpu=all \
#   <IMAGE NAME> bash
#
# Run: (one-line)
# >>> podman run -it --rm --env OPENAI_API_KEY --env OPENAI_ENDPOINT -v outputs:/root/benchmark-robotics-llm/outputs --device nvidia.com/gpu=all <IMAGE NAME> bash
#
# Description:
# [x] Add mamba package manager
# [x] Add pipx package manager
# [x] Add oh-my-posh terminal
# [x] Add vim awesome
# [x] Add VsCode server
# 
# References:
# * https://stackoverflow.com/questions/58269375/how-to-install-packages-with-miniconda-in-dockerfile
# * https://pythonspeed.com/articles/activate-conda-dockerfile/
#====================================================

FROM nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

LABEL org.opencontainers.image.source https://github.com/destin-v/benchmark-robotics-llm

# Disable interaction
# Set ARG as this is only available during build
ARG DEBIAN_FRONTEND=noninteractive

# Common packages
RUN apt -y update &&\ 
    apt -y upgrade &&\
    apt -y install \
    build-essential \
    ca-certificates \
    curl \
    freeglut3-dev \
    git \
    git-lfs \
    htop \
    lcov \
    libhdf5-dev \
    libomp-dev \
    libjpeg-dev \
    libglm-dev \
    libegl1-mesa-dev \
    ninja-build \
    pipx \
    unzip \
    vim \
    wget \
    xorg-dev \
    zip &&\
    apt -y clean

# Install CMake
RUN wget https://cmake.org/files/v3.12/cmake-3.12.4-Linux-x86_64.sh
RUN mkdir /opt/cmake312
RUN sh ./cmake-3.12.4-Linux-x86_64.sh --prefix=/opt/cmake312 --skip-license
RUN ln -s /opt/cmake312/bin/cmake /usr/local/bin/cmake
RUN ln -s /opt/cmake312/bin/ctest /usr/local/bin/ctest

# Install pipx
RUN pipx ensurepath
RUN pipx install nvitop

WORKDIR /root/

# Install Mamba
ENV PATH="/root/.local/bin/:$PATH"
ARG PATH="/root/.local/bin/:$PATH"
RUN curl -L micro.mamba.pm/install.sh | bash -s

# Oh my Posh
RUN curl -s https://ohmyposh.dev/install.sh | bash -s
RUN echo 'eval "$(oh-my-posh init bash)"' >> ~/.bashrc
RUN echo 'source .bashrc' >> ~/.profile
RUN echo 'PATH=$PATH:~/.local/bin/' >> ~/.bashrc

# VIM configuration
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime &&\
    sh ~/.vim_runtime/install_awesome_vimrc.sh

# To create a Mamba environment.  Need --format docker in build.
RUN micromamba create -n myenv python=3.9.16 cmake=3.14.0 -y
SHELL ["micromamba", "run", "-n", "myenv", "/bin/bash", "-c"]

# Installation of Habitat & PARTNR LLM
RUN git clone https://github.com/destin-v/benchmark-robotics-llm.git
WORKDIR /root/benchmark-robotics-llm
RUN git submodule sync
RUN git submodule update --init --recursive

# Adjust the cuda version depending on your hardware stack
RUN micromamba install pytorch==2.4.1 torchvision==0.19.1 torchaudio==2.4.1 pytorch-cuda=12.4 -c pytorch -c nvidia -y

# Install habitat-sim version 0.3.3
RUN micromamba install habitat-sim=0.3.3 withbullet headless -c conda-forge -c aihabitat -y

# NOTE: If the above fails, packages may not be available for your system. Install from source (see https://github.com/facebookresearch/habitat-sim).
RUN pip install -e ./third_party/habitat-lab/habitat-lab
RUN pip install -e ./third_party/habitat-lab/habitat-baselines
RUN pip install -e ./third_party/transformers-CFG
RUN pip install -r requirements.txt

# Set library path
ENV export LD_LIBRARY_PATH=/root/micromamba/envs/myenv/lib/:$LD_LIBRARY_PATH

# Install Git LFS
RUN git lfs install

# You may have to re-run downloader commands in case of network errors.
RUN python -m habitat_sim.utils.datasets_download --uids rearrange_task_assets hab_spot_arm hab3-episodes habitat_humanoids --data-path data/ --no-replace --no-prune

# Download ovmm objects
RUN git clone https://huggingface.co/datasets/ai-habitat/OVMM_objects data/objects_ovmm --recursive

# Download and link the data.
RUN git clone -b partnr https://huggingface.co/datasets/hssd/hssd-hab data/versioned_data/hssd-hab
RUN cd data/versioned_data/hssd-hab && git lfs pull
RUN ln -s versioned_data/hssd-hab data/hssd-hab

# Download the data
RUN git clone https://huggingface.co/datasets/ai-habitat/partnr_episodes data/versioned_data/partnr_episodes
RUN cd data/versioned_data/partnr_episodes && git lfs pull

# Link task datasets
RUN mkdir -p data/datasets
RUN ln -s ../versioned_data/partnr_episodes data/datasets/partnr_episodes

# Link skill checkpoints
RUN ln -s versioned_data/partnr_episodes/checkpoints data/models

# Optional add-ons
RUN pip install pybullet==3.0.4
RUN pip install pre-commit && pre-commit install
RUN pip install -e .

# Add the following to your ~/.bashrc file
ENV OPENAI_API_KEY="YOUR_OPENAI_KEY"
ENV OPENAI_ENDPOINT="/v1/chat/completions"

# Run tests
# =========
# Download and link the data.
RUN git clone https://huggingface.co/datasets/ai-habitat/hssd-partnr-ci data/versioned_data/hssd-partnr-ci
RUN ln -s versioned_data/hssd-partnr-ci data/hssd-partnr-ci
RUN cd data/hssd-partnr-ci && git lfs pull

# link RAG testing data
RUN ln -s versioned_data/partnr_episodes/test_rag data/test_rag

# Add Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Add VsCode server for editing
RUN curl -fsSL https://code-server.dev/install.sh | sh

EXPOSE 8080

# code-server by default runs on 127.0.0.1 (only reachable inside the container).
ENTRYPOINT ["code-server", "--auth", "none", "--bind-addr", "0.0.0.0:8080"]

# Connect to the VsCode server using:
# 0.0.0.0:8080

