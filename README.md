# RaspberryPi Automation Setup

The purpose of this repo is to have an automated way to setup a RaspberryPi
just the way I want. Things I like:

* [Go](https://golang.org/)
* [Docker](https://www.docker.com/)
* [Kubernetes](https://kubernetes.io/)
* [etcd](https://coreos.com/etcd)
* [cfssl](https://github.com/cloudflare/cfssl)

Most of the technologies above are _not_ pre-built for `arm` architectures, so
this repository is intended to help ease the setup and installation of those
technologies on a RaspberryPi.

## Use

```bash
git clone https://github.com/micahhausler/rpi-automation.git
cd rpi-automation
./setup.sh
```

## Configuration

* `GITHUB_USERNAME` - The username of the github user to fetch the SSH keys (defaults to `micahhausler`)
* `GO_VERSION` - The go version to install (defaults to `1.8.3`)

## Installs

Things to automate:

- [ ] passwd reset
- [ ] dotfiles
- [x] ssh key setup (from github?)
- [x] pkg installs
- [x] [Go install](https://golang.org/doc/install/source)
- [x] Docker install

## Customizations

- [x] run docker with `--experimental --metrics-addr 127.0.0.1:9000`
- [x] rewrite docker systemd to accept drop-ins

## Prometheus

- [ ] Prometheus arm7 container
- [ ] prom/node_exporter arm7 container
- [ ] cadvisor arm7 container
- [ ] Prometheus volume/storage management (probably use a usb stick, mount that)
- [ ] Prometheus graphs

## Kubernetes

- [ ] upload ARM binaries to s3
- [ ] `sudo genman /usr/share/man/man1/ kube*`
- [ ] `kubectl completion bash > /etc/bash_completion.d/kubectl`

## Other resources

- [ ] CFSSL created CA
- [ ] CFSSL Server
- [ ] etcd v3 server

## About this repo

### Commit Message Conventions
Once you’ve implemented a bug fix or feature, please use the following commit
message format. In order to track and summarize the changes, we could use a
changelog automation tool called clog which scrapes information from commit
messages. We follow the ‘conventional’ commit message format.

As a summary, messages should be formatted like:

```
<type>(<scope>): <subject>
<empty line>
<body>
<empty line>
<footer>
```

####  Type

Type | Purpose
--------|------------
feat | A new feature. Please also link to the issue (in the body) if applicable. Causes a minor version bump.
fix | A bug fix. Please also link to the issue (in the body) if applicable.
docs | A documentation change.
style | A code change that does not affect the meaning of the code, (e.g. indentation).
refactor | A code change that neither fixes a bug or add a feature.
perf | A code change that improves performance.
test | Adding missing tests.
chore | Changes to build process or auxiliary tools or libraries such as documentation generation.
config | Changes to configurations that have tangible effects on users, (e.g. renaming properties, changing defaults, etc).

