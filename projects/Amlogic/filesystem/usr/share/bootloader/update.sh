#!/bin/sh

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
[ -z "$UPDATE_DIR" ] && UPDATE_DIR="/storage/.update"
UPDATE_DTB_IMG="$UPDATE_DIR/dtb.img"
UPDATE_DTB=`ls -1 "$UPDATE_DIR"/*.dtb 2>/dev/null | head -n 1`
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

for arg in $(cat /proc/cmdline); do
  case $arg in
    boot=*)
      echo "*** updating BOOT partition label ..."
      boot="${arg#*=}"
      case $boot in
        /dev/mmc*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/fatlabel $boot "LIBREELEC"
          ;;
        LABEL=*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/fatlabel $($SYSTEM_ROOT/usr/sbin/findfs $boot) "LIBREELEC"
          ;;
      esac

      if [ -f "/proc/device-tree/le-dt-id" ] ; then
        LE_DT_ID=$(cat /proc/device-tree/le-dt-id)
      else
        echo "*** remember to update your device tree! ***"
      fi

      if [ -f "$UPDATE_DTB_IMG" ] ; then
        UPDATE_DTB_SOURCE="$UPDATE_DTB_IMG"
      elif [ -f "$UPDATE_DTB" ] ; then
        UPDATE_DTB_SOURCE="$UPDATE_DTB"
      elif [ -n "$LE_DT_ID" -a -f "$SYSTEM_ROOT/usr/share/bootloader/$LE_DT_ID.dtb" ] ; then
        UPDATE_DTB_SOURCE="$SYSTEM_ROOT/usr/share/bootloader/$LE_DT_ID.dtb"
      fi

      if [ -f "$UPDATE_DTB_SOURCE" ] ; then
        echo "*** updating device tree from $UPDATE_DTB_SOURCE ..."
        case $boot in
          /dev/system)
            dd if=/dev/zero of=/dev/dtb bs=256k count=1 status=none
            dd if="$UPDATE_DTB_SOURCE" of=/dev/dtb bs=256k status=none
            ;;
          /dev/mmc*|LABEL=*)
            mount -o rw,remount $BOOT_ROOT
            cp -f "$UPDATE_DTB_SOURCE" "$BOOT_ROOT/dtb.img"
            ;;
        esac
      fi
      ;;
    disk=*)
      echo "*** updating DISK partition label ..."
      disk="${arg#*=}"
      case $disk in
        /dev/mmc*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/e2label $disk "STORAGE"
          ;;
        LABEL=*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/e2label $($SYSTEM_ROOT/usr/sbin/findfs $disk) "STORAGE"
          ;;
      esac
      ;;
  esac
done

if [ -f $SYSTEM_ROOT/usr/share/bootloader/boot.ini ]; then
  echo "*** updating boot.ini ..."
  mount -o rw,remount $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/boot.ini $BOOT_ROOT/boot.ini
fi

if [ -f $SYSTEM_ROOT/usr/share/bootloader/boot-logo.bmp.gz ]; then
  echo "*** updating boot logo ..."
  mount -o rw,remount $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/boot-logo.bmp.gz $BOOT_ROOT
fi

if [ -f $SYSTEM_ROOT/usr/share/bootloader/u-boot -a ! -e /dev/system -a ! -e /dev/boot ]; then
  echo "*** updating u-boot on: $BOOT_DISK ..."
  dd if=$SYSTEM_ROOT/usr/share/bootloader/u-boot of=$BOOT_DISK conv=fsync bs=1 count=112 status=none
  dd if=$SYSTEM_ROOT/usr/share/bootloader/u-boot of=$BOOT_DISK conv=fsync bs=512 skip=1 seek=1 status=none
fi
