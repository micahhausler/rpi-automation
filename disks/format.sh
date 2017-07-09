#!/usr/bin/env bash

ser -e

echo "Found the following disks:"
ls  /dev/sd*[a-z]

read -p "Which disk? (ex: sda) " disk
DISK="/dev/$disk"
echo

if [ -n "disk" -a -b $DISK ]; then
    ls -al $DISK
    sudo mkfs -t ext4 $DISK
else
    echo "Could not find $DISK!"
    exit 1
fi

echo
read -p "Do you want to mount this volume to a directory? (y or n) " yn
case $yn in
    [Yy]* )
        read -p "What drectory to mount? " directory
        if [ ! -d $directory ]; then
            sudo mkdir -p $directory
        fi
        sudo mount $DISK $directory
        df -h $DISK
        ;;
    [Nn]* )
        exit
        ;;
esac
