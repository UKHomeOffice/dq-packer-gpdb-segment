#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin

set -e
set -x

if ! $(df -T | grep -q /dev/nvme0n1); then
  mkfs.xfs -f /dev/nvme0n1
  mount -o nodev,noatime,inode64,allocsize=16m /dev/nvme0n1 /gpdb
  echo "/dev/nvme0n1 /gpdb xfs nodev,noatime,inode64,allocsize=16m 0 0" >> /etc/fstab
  dd if=/dev/zero of=/dm-2 count=65536 bs=1MiB
  chmod 600 /dm-2
  mkswap /dm-2
  swapon -v /dm-2
  echo "/dm-2 swap swap defaults 0 0" >> /etc/fstab
  dhclient
else
  dhclient
fi
