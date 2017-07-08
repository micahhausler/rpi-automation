#!/usr/bin/env bash

if [ ! -f /usr/bin/dockerd ]; then
    # Install Docker
    curl -sSL https://get.docker.com | sh

    # Add pi to docker group
    sudo usermod -aG docker pi
fi

# Modify systemd unit
sudo cp ./systemd.d/docker.service /lib/systemd/system/docker.service

# Add drop-in
sudo mkdir -p /etc/systemd/system/docker.service.d
sudo cp ./systemd.d/10-docker.conf /etc/systemd/system/docker.service.d/

# Restart docker
sudo systemctl daemon-reload
sudo systemctl restart docker
