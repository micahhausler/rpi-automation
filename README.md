# RaspberryPi

Things to automate:

- passwd reset
- ssh key setup (from github?)
- pkg installs
- [Go install](https://golang.org/doc/install/source)
- Docker install
- dotfiles

- run docker with `--experimental --metrics-addr 127.0.0.1:9000`
- rewrite docker systemd to accept drop-ins

- Prometheus arm7 container
- prom/node_exporter arm7 container
- cadvisor arm7 container

- Prometheus volume/storage management (probably use a usb stick, mount that)
- Prometheus graphs

## Kubernetes

- upload ARM binaries to s3
- `sudo genman /usr/share/man/man1/ kube*`
- `kubectl completion bash > /etc/bash_completion.d/kubectl`
