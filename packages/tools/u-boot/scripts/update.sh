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

[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$BOOT_DISK" ] && BOOT_DISK=$(df "$BOOT_ROOT" |tail -1 |awk {' print $1 '})
[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""

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
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/u-boot.img ]; then
    echo "*** updating u-boot image: $BOOT_ROOT/u-boot.img ..."
    cp -p $SYSTEM_ROOT/usr/share/bootloader/u-boot.img $BOOT_ROOT
  fi

  if [ -f $SYSTEM_ROOT/usr/share/bootloader/SPL ]; then
    echo "*** updating u-boot SPL Blob on: $BOOT_DISK ..."
    dd if="$SYSTEM_ROOT/usr/share/bootloader/SPL" of="$BOOT_DISK" bs=1k seek=1 conv=fsync
  fi

  # prefer uEnv.txt over boot.scr
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/uEnv.txt -a ! -f $BOOT_ROOT/uEnv.txt ]; then
    cp -p $SYSTEM_ROOT/usr/share/bootloader/uEnv.txt $BOOT_ROOT
  elif [ -f $SYSTEM_ROOT/usr/share/bootloader/boot.scr -a ! -f $BOOT_ROOT/boot.scr ]; then
    cp -p $SYSTEM_ROOT/usr/share/bootloader/boot.scr $BOOT_ROOT
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
