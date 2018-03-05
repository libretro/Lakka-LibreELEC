################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
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

# mount $BOOT_ROOT r/w
  mount -o remount,rw $BOOT_ROOT

# update device tree
  for all_dtb in $BOOT_ROOT/*.dtb; do
    dtb=$(basename $all_dtb)
    if [ -f $SYSTEM_ROOT/usr/share/bootloader/$dtb ]; then
      echo -n "Updating $dtb... "
      cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT
      echo "done"
    fi
  done

# update bootloader
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/idbloader.img ]; then
    echo -n "Updating idbloader.img... "
    dd if=$SYSTEM_ROOT/usr/share/bootloader/idbloader.img of=$BOOT_DISK bs=32k seek=1 conv=fsync &>/dev/null
    echo "done"
  fi
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/uboot.img ]; then
    echo -n "Updating uboot.img... "
    dd if=$SYSTEM_ROOT/usr/share/bootloader/uboot.img of=$BOOT_DISK bs=64k seek=128 conv=fsync &>/dev/null
    echo "done"
  fi
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/trust.img ]; then
    echo -n "Updating trust.img... "
    dd if=$SYSTEM_ROOT/usr/share/bootloader/trust.img of=$BOOT_DISK bs=64k seek=192 conv=fsync &>/dev/null
    echo "done"
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
