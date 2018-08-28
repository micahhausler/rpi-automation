#!/usr/bin/env bash

export INSTALL_PYTHON="${INSTALL_PYTHON:-true}"
export GITHUB_USERNAME="${GITHUB_USERNAME:-}"
export INSTALL_DOCKER="${INSTALL_DOCKER:-true}"
export INSTALL_GO="${INSTALL_GO:-true}"
export INSTALL_HW_CLOCK="${INSTALL_HW_CLOCK:-true}"
export HW_CLOCK_MODEL="${HW_CLOCK_MODEL:-pcf8523}"
export SYNC_HW_CLOCK="${SYNC_HW_CLOCK:-true}"

# Execute all setup scripts
for f in ./setup.d/*; do
    filetype=$(stat  -c %F $f)
    if [ "$filetype" == "regular file" ]; then
        bash $f;
    fi
done
