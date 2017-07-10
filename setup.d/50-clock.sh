#!/usr/bin/env bash

set -e

# Setup a real time clock
#
# Following Adafruit guides:
# * https://learn.adafruit.com/adafruits-raspberry-pi-lesson-4-gpio-setup/configuring-i2c
# * https://learn.adafruit.com/adding-a-real-time-clock-to-raspberry-pi?view=all

if [ "$INSTALL_HW_CLOCK" != "true" ]; then
    exit;
fi

# Add i2c to /etc/modules
if [ "$(grep -c i2c-bcm2708 /etc/modules)" == "0" ]; then
    echo "i2c-bcm2708" | sudo tee -a /etc/modules
fi


# Un-blacklist i2c if present
MODPROBE_FILE="/etc/modprobe.d/raspi-blacklist.conf"
if [ -f $MODPROBE_FILE ]; then
    if [ "$(grep -c i2c-bcm2708 $MODPROBE_FILE)" != "0" ]; then
        cat $MODPROBE_FILE | sed -e 's/blacklist i2c-bcm2708/#blacklist i2c-bcm2708/g' | sudo tee $MODPROBE_FILE
    fi
    if [ "$(grep -c spi-bcm2708 $MODPROBE_FILE)" != "0" ]; then
        cat $MODPROBE_FILE | sed -e 's/blacklist spi-bcm2708/#blacklist spi-bcm2708/g' | sudo tee $MODPROBE_FILE
    fi
fi

# Add lines to /boot/config.txt
append_to_boot_file() {
    BOOT_FILE="/boot/config.txt"
    line=$1
    if [ -f $BOOT_FILE ]; then
        if [ "$(cat $BOOT_FILE | grep -v "^#" | grep -c '$line')" == "0" ]; then
            echo "$line" | sudo tee -a $BOOT_FILE
        fi
    fi
}

append_to_boot_file "dtparam=i2c1=on"
append_to_boot_file "dtparam=i2c_arm=on"
append_to_boot_file "dtoverlay=i2c-rtc,${HW_CLOCK_MODEL}"

# If fake-hwclock is still installed, reboot

FAKE_HW=$(apt list --installed | grep -v "deinstall" | grep -c fake-hwclock)
if [ "$FAKE_HW" == "1" ]; then
    echo "Must reboot to use clock!"
    sudo shutdown -r +1
    exit
fi

# Remove fake HW clock
sudo apt-get -y remove fake-hwclock
sudo update-rc.d -f fake-hwclock remove

sudo cp ./50-clock.d/hwclock-set /lib/udev/hwclock-set

# Read what the clock says
sudo hwclock -D -r

if [ "$SYNC_HW_CLOCK" == "true" ]; then
    exit;
        sudo hwclock -w -D
fi
