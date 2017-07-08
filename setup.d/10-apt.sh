#!/usr/bin/env bash

# Install development tools
sudo apt-get update
sudo apt-get install -y \
    conntrack \
    curl \
    git \
    htop \
    jq \
    less \
    man \
    socat \
    vim \
    wget \
    x11-apps

sudo chown -R pi:pi /usr/local/
