#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"

IMAGE_KERNEL="/flash/kernel.img"

# parse command line arguments
for arg in $(cat /proc/cmdline); do
  case $arg in
    BOOT_IMAGE=*)
      IMAGE_KERNEL="${arg#*=}"
    ;;
  esac
done


# mount $BOOT_ROOT r/w
  mount -o remount,rw $BOOT_ROOT

if [ -b $IMAGE_KERNEL ]; then
  dd if="$SYSTEM_ROOT/usr/share/bootloader/dtb.img" of="/dev/dtb" bs=262144 2>&1
else
  cp -p $SYSTEM_ROOT/usr/share/bootloader/dtb.img $BOOT_ROOT
fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
