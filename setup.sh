#!/usr/bin/env bash

# Execute all setup scripts
for f in ./setup.d/*; do
    bash $f;
done
