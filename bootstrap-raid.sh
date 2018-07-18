#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin

set -e
set -x

if ! $(df -T | grep /dev/nvme0n1); then
  mkfs.xfs -f /dev/nvme0n1
  mount -o nodev,noatime,inode64,allocsize=16m /dev/nvme0n1 /ephemeral
  dd if=/dev/zero of=/ephemeral/swap count=65536 bs=1MiB
  chmod 600 /ephemeral/swap
  mkswap /ephemeral/swap
  swapon -v /ephemeral/swap
  dhclient
else
  mount -o nodev,noatime,inode64,allocsize=16m /dev/nvme0n1 /ephemeral
  dd if=/dev/zero of=/ephemeral/swap count=65536 bs=1MiB
  chmod 600 /ephemeral/swap
  mkswap /ephemeral/swap
  swapon -v /ephemeral/swap
  dhclient
fi
