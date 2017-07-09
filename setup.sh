#!/usr/bin/env bash

export GITHUB_USERNAME="${GITHUB_USERNAME:-}"
export INSTALL_DOCKER="${INSTALL_DOCKER:-true}"
export INSTALL_GO="${INSTALL_GO:-true}"

# Execute all setup scripts
#for f in ./setup.d/*; do
for f in ./setup2/*; do
    bash $f;
done
