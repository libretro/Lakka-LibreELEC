#!/bin/sh

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
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

# update Device Tree Blobs
  for all_dtb in /flash/*.dtb; do
    dtb=$(basename $all_dtb)
    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$dtb ]; then
      echo "*** updating Device Tree Blob: $dtb ..."
      cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT
    fi
  done

# update bootloader files
  UBOOT="${SYSTEM_ROOT}/usr/share/bootloader/flash.bin"
  if [ -f "${UBOOT}" ]; then
    DEVICE="$(basename ${BOOT_DISK})"
    if grep -q "MMC" /sys/class/block/${DEVICE}/device/type; then
      echo 0 > /sys/block/${DEVICE}boot0/force_ro
      echo "*** updating u-boot image on: ${BOOT_DISK}boot0 ..."
      dd if="${UBOOT}" of="${DEVICE}boot0" bs=1024 seek=33 conv=fsync > /dev/null 2>&1
      echo 0 > /sys/block/${DEVICE}boot1/force_ro
      echo "*** updating u-boot image on: ${BOOT_DISK}boot1 ..."
      dd if="${UBOOT}" of="${DEVICE}boot1" bs=1024 seek=33 conv=fsync > /dev/null 2>&1
    else
      echo "*** updating u-boot image on: ${BOOT_DISK} ..."
      dd if="${UBOOT}" of="$BOOT_DISK" bs=1024 seek=33 conv=fsync &>/dev/null
    fi
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
