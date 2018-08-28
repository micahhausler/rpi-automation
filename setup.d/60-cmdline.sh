#!/usr/bin/env bash

set -e

BOOT_FILE="/boot/cmdline.txt"

if [ "$(grep -c cgroup_enable $BOOT_FILE)" == "0" ]; then
    sudo sed -i -e "s/rootwait/rootwait cgroup_enable=cpuset cgroup_enable=memory/" $FILE
fi
