#!/usr/bin/env bash
set -e

PATCH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/prometheus/Makefile.patch"

export PROM_VERSION="${PROM_VERSION:-v2.0.0-beta.0}"

PROMETHEUS_SRC="github.com/prometheus/prometheus"
PROM_PATH="$GOPATH/src/$PROMETHEUS_SRC"

# Prometheus
mkdir -p $PROM_PATH
cd $PROM_PATH/..

if [ ! -f "$PROM_PATH/README.md" ]; then
    git clone https://github.com/prometheus/prometheus.git
fi

cd $PROM_PATH
git checkout $PROM_VERSION
git stash
git apply $PATCH
make -j 2 build

for bin in {promtool,prometheus}; do
    if [ -f "$PROM_PATH/$bin" ]; then
        aws s3 cp $PROM_PATH/$bin s3://$S3_BUCKET/$OS/$ARCH/$bin
    fi
done
