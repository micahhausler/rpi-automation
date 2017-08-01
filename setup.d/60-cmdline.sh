#!/usr/bin/env bash

set -e

FILE="/boot/cmdline.txt"

echo "dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=PARTUUID=a2bed435-02 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait cgroup_enable=cpuset cgroup_enable=memory" | sudo tee $FILE
