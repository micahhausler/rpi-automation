#!/usr/bin/env bash
set -e

export K8S_VERSION="${K8S_VERSION:-v1.7.2}"
export GOOS=linux GOARCH=arm GOARM=6
export K8S_PATH="$GOPATH/src/k8s.io/kubernetes"

mkdir -p $K8S_PATH
git clone https://github.com/kubernetes/kubernetes.git $K8S_PATH

cd $K8S_PATH
git checkout $K8S_VERSION

BROKEN_FILE="$K8S_PATH/staging/src/k8s.io/apiextensions-apiserver/test/integration/testserver/resources.go"
cat $BROKEN_FILE | sed -e 's/9223372036854775807/9223372036854/g' | tee $BROKEN_FILE

# Build it
KUBE_BUILD_PLATFORMS=linux/arm make
for cmd in cmd/kubelet cmd/kubectl cmd/kube-proxy cmd/kube-apiserver cmd/kube-controller-manager cmd/kubeadm plugin/cmd/kube-scheduler cmd/genman ; do
    time KUBE_BUILD_PLATFORMS=linux/arm make all WHAT=$cmd GOFLAGS=-v
done


MAN_DIR="/usr/share/man/man1"
for bin in kubelet kubectl kube-proxy kube-apiserver kube-controller-manager kube-scheduler ; do
    sudo ./_output/bin/genman $MAN_DIR $bin
done

cp _output/bin/kube* /usr/local/bin/

for bin in {kubectl,kubelet,kube-proxy,kube-apiserver,kube-controller-manager,kubeadm,kube-scheduler,genman}; do
    if [ -f "$K8S_PATH/_output/bin/$bin" ]; then
        cp $K8S_PATH/_output/bin/$bin /usr/local/bin/
        aws s3 cp $K8S_PATH/_output/bin/$bin s3://$S3_BUCKET/$OS/$ARCH/kubernetes/$K8S_VERSION/$bin
    fi
done
