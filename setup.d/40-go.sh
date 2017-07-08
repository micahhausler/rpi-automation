#/usr/bin/env bash

VERSION="1.8.3"
OS="linux"
ARCH="armv6l"

if [[ ! -d /usr/local/go ]];
    mkdir -p /usr/local/go;
fi

TARBALL="go$VERSION.$OS-$ARCH.tar.gz"
URL="https://storage.googleapis.com/golang/$TARBALL"

wget --progress dot:mega -P /tmp $URL
tar -C /usr/local -xzf /tmp/$TARBALL
