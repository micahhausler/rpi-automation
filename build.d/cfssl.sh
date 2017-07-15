#!/usr/bin/env bash
set -e

# CFSSL
go get -u github.com/cloudflare/cfssl/cmd/...
for bin in {cfssl,cfssljson}; do
    if [ -f "$GOPATH/bin/$bin"]; then
        aws s3 cp $GOPATH/bin/$bin s3://$S3_BUCKET/$OS/$ARCH/$bin
    fi
done

