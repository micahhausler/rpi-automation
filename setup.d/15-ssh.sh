#!/usr/bin/env bash

## Downloads a Github user's SSH keys and sets them to ~/.ssh/authorized_keys

if [ -z "$GITHUB_USERNAME" ]; then
    exit;
fi

BODY=$(curl -s https://api.github.com/users/$GITHUB_USERNAME/keys)
if [ "$(echo $BODY | jq -r 'type')" == "array" ]; then
    mkdir -p ~/.ssh
    echo $BODY | jq -r .[].key > ~/.ssh_authorized_keys
else
    echo "Github user '$GITHUB_USERNAME' not found:"
    echo "    $BODY"
fi
