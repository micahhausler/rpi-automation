#!/usr/bin/env bash

################
# Build Script #
################
#
# This script is not intended to be run on a raspberry pi, as some programs
# require too much memory to build

set -e

export S3_BUCKET="${S3_BUCKET:-micahhausler-uploads}"
export AWS_DEFAULT_PROFILE=personal
export AWS_DEFAULT_REGION="us-west-2"
export GOPATH="~/go"

ARCH="armv7l"
OS="Linux"

# Execute all build scripts
for f in ./build.d/*; do
    bash $f;
done
