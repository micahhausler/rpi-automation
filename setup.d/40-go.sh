#!/usr/bin/env bash

set -e

# Install the Go language

if [ "$INSTALL_GO" != "true" ]; then
    echo "Skipping go install"
    exit;
fi

GO_VERSION="${GO_VERSION:-1.8.3}"
OS="linux"
ARCH="armv6l"

if [[ ! -d /usr/local/go ]]; then
    mkdir -p /usr/local/go;
fi

if [ ! -f /usr/local/go/bin/go ]; then
    if [ "$(/usr/local/go/bin/go version)" != "go version go$GO_VERSION linux/arm" ]; then
        TARBALL="go$GO_VERSION.$OS-$ARCH.tar.gz"
        URL="https://storage.googleapis.com/golang/$TARBALL"

        wget --progress dot:mega -P /tmp $URL
        tar -C /usr/local -xzf /tmp/$TARBALL
    fi
fi
