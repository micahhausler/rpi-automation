#!/usr/bin/env bash

set -e

if [ "$INSTALL_PYTHON" != "true" ]; then
    echo "Skipping python install"
    exit;
fi

PYTHON_VERSION="${PYTHON_VERSION:-3.6.2}"

if [ -f /usr/local/bin/python3 ]; then
    PY3_VERSION=$(python3 --version 2>&1 | cut -f 2 -d' ')
    if [ "$PY3_VERSION" == "${PYTHON_VERSION}" ]; then
        exit 0;
    fi
fi


# Install build tools
sudo apt-get update
sudo apt-get install -y \
    build-essential \
    tk-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline6-dev \
    libdb5.3-dev \
    libgdbm-dev \
    libsqlite3-dev \
    libssl-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    zlib1g-dev


# Install
WORKDIR="/tmp/python-build"
mkdir -p $WORKDIR
cd $WORKDIR
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz
tar xf Python-$PYTHON_VERSION.tar.xz
cd ./Python-$PYTHON_VERSION
./configure
make -j 4
make install

cd $HOME

# Cleanup
sudo rm -r $WORKDIR/
sudo apt-get --purge -y remove \
    build-essential \
    tk-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline6-dev \
    libdb5.3-dev \
    libgdbm-dev \
    libsqlite3-dev \
    libssl-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    zlib1g-dev
sudo apt-get autoremove -y
sudo apt-get clean -y
