#!/usr/bin/env bash

set -e

if [ "$INSTALL_PYTHON" != "true" ]; then
    echo "Skipping pip installs"
    exit;
fi


pip3 install \
    awscli
