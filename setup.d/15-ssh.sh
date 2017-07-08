#!/usr/bin/env bash

## Downloads a Github user's SSH keys and sets them to ~/.ssh/authorized_keys

# TODO: Prompt for username if none is set, remove micahhausler
GITHUB_USERNAME="${GITHUB_USERNAME:-micahhausler}"

if [ -n "$GITHUB_USERNAME" ]; then
    BODY=$(curl -s https://api.github.com/users/$GITHUB_USERNAME/keys)
    if [ "$(echo $BODY | jq -r 'type')" == "array" ]; then
        mkdir -p ~/.ssh
        echo $BODY | jq -r .[].key > ~/.ssh_authorized_keys
    fi
fi
