#!/bin/sh

################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

for arg in $(cat /proc/cmdline); do
  case $arg in
    boot=*)
      boot="${arg#*=}"
      case $boot in
        /dev/mmc*)
          $SYSTEM_ROOT/usr/sbin/fatlabel $boot "LAKKA"
          ;;
        LABEL=*)
          $SYSTEM_ROOT/usr/sbin/fatlabel $($SYSTEM_ROOT/sbin/findfs $boot) "LAKKA"
          ;;
      esac
      ;;
    disk=*)
      disk="${arg#*=}"
      case $disk in
        /dev/mmc*)
          $SYSTEM_ROOT/sbin/e2label $disk "LAKKA_DISK"
          ;;
        LABEL=*)
          $SYSTEM_ROOT/sbin/e2label $($SYSTEM_ROOT/sbin/findfs $disk) "LAKKA_DISK"
          ;;
      esac
      ;;
  esac
done
