#!/usr/bin/env bash
set -e

export K8S_VERSION="${K8S_VERSION:-v1.7.0}"
export GOOS=linux GOARCH=arm GOARM=6

K8S_PATH="$GOPATH/src/k8s.io/kubernetes"
mkdir -p $K8S_PATH
git clone https://github.com/kubernetes/kubernetes.git $K8S_PATH

cd $K8S_PATH
git checkout $K8S_VERSION

BROKEN_FILE="$K8S_PATH/staging/src/k8s.io/apiextensions-apiserver/test/integration/testserver/resources.go"
cat $BROKEN_FILE | sed -e 's/9223372036854775807/9223372036854/g' | tee $BROKEN_FILE

# Build it
KUBE_BUILD_PLATFORMS=linux/arm make

# Binaries are here
ls _output/local/bin/linux/arm/
