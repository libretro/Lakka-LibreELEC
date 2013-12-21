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
[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""

# mount $BOOT_ROOT r/w
  mount -o remount,rw $BOOT_ROOT

# update bootloader files
  cp -p $SYSTEM_ROOT/usr/share/bootloader/LICENCE* $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/bootcode.bin $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/fixup.dat $BOOT_ROOT
  cp -p $SYSTEM_ROOT/usr/share/bootloader/start.elf $BOOT_ROOT

# cleanup not more needed files
  rm -rf $BOOT_ROOT/loader.bin
  rm -rf $BOOT_ROOT/fixup_x.dat
  rm -rf $BOOT_ROOT/start_x.elf

# some config.txt magic
  if [ ! -f $BOOT_ROOT/config.txt ]; then
    cp -p $SYSTEM_ROOT/usr/share/bootloader/config.txt $BOOT_ROOT
  elif [ -z "`grep "^[ ]*gpu_mem.*" $BOOT_ROOT/config.txt`" ]; then
    mv $BOOT_ROOT/config.txt $BOOT_ROOT/config.txt.bk
    cat $SYSTEM_ROOT/usr/share/bootloader/config.txt \
        $BOOT_ROOT/config.txt.bk > $BOOT_ROOT/config.txt
  else
    sed -e "s,# gpu_mem_256=128,gpu_mem_256=100,g" -i $BOOT_ROOT/config.txt
    sed -e "s,# gpu_mem_512=128,gpu_mem_512=128,g" -i $BOOT_ROOT/config.txt
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
