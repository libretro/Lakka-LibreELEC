#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

  [ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
  [ -z "$BOOT_PART" ] && BOOT_PART=$(df "$BOOT_ROOT" | tail -1 | awk {' print $1 '})
  if [ -z "$BOOT_DISK" ]; then
    case $BOOT_PART in
      /dev/sd[a-z][0-9]*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,[0-9]*,,g")
        ;;
      /dev/mmcblk*)
        BOOT_DISK=$(echo $BOOT_PART | sed -e "s,p[0-9]*,,g")
        ;;
    esac
  fi

# mount $BOOT_ROOT r/w
  mount -o remount,rw $BOOT_ROOT

# update extlinux device trees
  for dtbfile in $BOOT_ROOT/*.dtb; do
    dtb=$(basename $dtbfile)
    echo "Updating $dtb"
    cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT/ 2>/dev/null || true
  done

# update bootloader
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/SPL ]; then
    echo "Updating u-boot SPL on $BOOT_DISK"
    dd if=$SYSTEM_ROOT/usr/share/bootloader/SPL of=$BOOT_DISK bs=1k seek=1 conv=fsync &>/dev/null
  fi

  if [ -f $SYSTEM_ROOT/usr/share/bootloader/u-boot.img ]; then
    echo "Updating u-boot image on $BOOT_DISK"
    dd if=$SYSTEM_ROOT/usr/share/bootloader/u-boot.img of=$BOOT_DISK bs=1k seek=69 conv=fsync &>/dev/null
    echo "done"
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
