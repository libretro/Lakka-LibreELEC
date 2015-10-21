#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

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

SYSTEM_TYPE=""
if [ -f $SYSTEM_ROOT/usr/lib/openelec/imx6-system-type ]; then
  . $SYSTEM_ROOT/usr/lib/openelec/imx6-system-type
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
  if [ "$SYSTEM_TYPE" = "matrix" ]; then
    if [ -f $SYSTEM_ROOT/usr/share/bootloader/u-boot-$SYSTEM_TYPE.imx ]; then
      echo "*** updating u-boot image in eMMC ..."
      # clean up u-boot parameters
      #dd if=/dev/zero of=/dev/mmcblk0 bs=1024 seek=384 count=8
      # access boot partition 1
      echo 0 > /sys/block/mmcblk0boot0/force_ro
      # write u-boot to eMMC
      dd if=$SYSTEM_ROOT/usr/share/bootloader/u-boot-$SYSTEM_TYPE.imx of=/dev/mmcblk0boot0 bs=1k seek=1 conv=fsync
      # re-enable read-only access
      echo 1 > /sys/block/mmcblk0boot0/force_ro
      # enable boot partion 1 to boot
      echo 8 > /sys/devices/soc0/soc.1/2100000.aips-bus/219c000.usdhc/mmc_host/mmc2/mmc2:0001/boot_config
    fi
  else
    if [ -n "$SYSTEM_TYPE" ]; then
      UBOOT_IMG_SRC=u-boot-$SYSTEM_TYPE.img
      SPL_SRC=SPL-$SYSTEM_TYPE
    else
      UBOOT_IMG_SRC=u-boot.img
      SPL_SRC=SPL
    fi

    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$UBOOT_IMG_SRC ]; then
      echo "*** updating u-boot image: $BOOT_ROOT/u-boot.img ..."
      cp -p $SYSTEM_ROOT/usr/share/bootloader/$UBOOT_IMG_SRC $BOOT_ROOT/u-boot.img
    fi

    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$SPL_SRC ]; then
      echo "*** updating u-boot SPL Blob on: $BOOT_DISK ..."
      dd if="$SYSTEM_ROOT/usr/share/bootloader/$SPL_SRC" of="$BOOT_DISK" bs=1k seek=1 conv=fsync
    fi
  fi

  # prefer uEnv.txt over boot.scr
  if [ -n "$SYSTEM_TYPE" -a -f $SYSTEM_ROOT/usr/share/bootloader/uEnv-$SYSTEM_TYPE.txt -a ! -f $BOOT_ROOT/uEnv.txt ]; then
    cp -p $SYSTEM_ROOT/usr/share/bootloader/uEnv-$SYSTEM_TYPE.txt $BOOT_ROOT/uEnv.txt
  elif [ -f $SYSTEM_ROOT/usr/share/bootloader/uEnv.txt -a ! -f $BOOT_ROOT/uEnv.txt ]; then
    cp -p $SYSTEM_ROOT/usr/share/bootloader/uEnv.txt $BOOT_ROOT
  elif [ -f $SYSTEM_ROOT/usr/share/bootloader/boot.scr -a ! -f $BOOT_ROOT/boot.scr ]; then
    cp -p $SYSTEM_ROOT/usr/share/bootloader/boot.scr $BOOT_ROOT
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
