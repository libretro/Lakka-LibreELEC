#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""

# mount $BOOT_ROOT r/w
  mount -o remount,rw $BOOT_ROOT

# update bootloader files
  cp $SYSTEM_ROOT/usr/share/bootloader/LICENCE* $BOOT_ROOT
  cp $SYSTEM_ROOT/usr/share/bootloader/bootcode.bin $BOOT_ROOT
  cp $SYSTEM_ROOT/usr/share/bootloader/fixup.dat $BOOT_ROOT
  cp $SYSTEM_ROOT/usr/share/bootloader/start.elf $BOOT_ROOT

# cleanup not more needed files
  rm -rf $BOOT_ROOT/loader.bin

# some config.txt magic
  if [ ! -f $BOOT_ROOT/config.txt ]; then
    cp $SYSTEM_ROOT/usr/share/bootloader/config.txt $BOOT_ROOT
  elif [ ! `grep "^[ ]*gpu_mem.*" $BOOT_ROOT/config.txt` ]; then
    mv $BOOT_ROOT/config.txt $BOOT_ROOT/config.txt.bk
    cat $SYSTEM_ROOT/usr/share/bootloader/config.txt \
        $BOOT_ROOT/config.txt.bk > $BOOT_ROOT/config.txt
  fi

# mount $BOOT_ROOT r/o
  sync
  mount -o remount,ro $BOOT_ROOT
