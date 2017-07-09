# Adding additional volumes

## Format

Use the `format.sh` script to create a volume on a specified disk.

```bash
$ ./format.sh
Found the following disks:
/dev/sda /dev/sdb
Which disk? (ex: sda) sda

mke2fs 1.43.3 (04-Sep-2016)
Found a dos partition table in /dev/sda
Proceed anyway? (y,n) y
Creating filesystem with 982528 4k blocks and 245760 inodes
Filesystem UUID: 244ff73e-69d5-450d-9bf4-78e442b7fa7b
Superblock backups stored on blocks:
    32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done
Writing inode tables: done
Creating journal (16384 blocks): done
Writing superblocks and filesystem accounting information: done

Do you want to mount this volume to a directory? (y or n) y
What drectory to mount? /opt/volume
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda        3.7G   15M  3.5G   1% /media/pi/244ff73e-69d5-450d-9bf4-78e442b7fa7b
```
