# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

#!/bin/sh

[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
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

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
