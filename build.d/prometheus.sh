#!/usr/bin/env bash
set -e

export PROM_VERSION="${PROM_VERSION:-v2.0.0-beta.0}"

# Prometheus
go get -u github.com/prometheus/prometheus/

PROM_PATH="$GOPATH/src/github.com/prometheus/prometheus"

cd $PROM_PATH
git checkout $PROM_VERSION

# Special hack
# on `promu` target
#
# GOOS=$(shell uname -s | tr A-Z a-z) \
# GOARCH=arm \
# GOARM=7 \
# $(GO) get -u github.com/prometheus/promu

#cp prometheus ~/go/bin/prometheus

for bin in {promtool,prometheus}; do
    if [ -f "$GOPATH/bin/$bin" ]; then
        aws s3 cp $GOPATH/bin/$bin s3://$S3_BUCKET/$OS/$ARCH/$bin
    fi
done


