#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)

[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""

# mount $BOOT_ROOT r/w
mount -o remount,rw $BOOT_ROOT

# Something has gone horribly wrong... clean up
[ -s $BOOT_ROOT/overlays ] || rm -fr $BOOT_ROOT/overlays $BOOT_ROOT/FSCK*.REC

# update bootloader files
cp -p $SYSTEM_ROOT/usr/share/bootloader/LICENCE* $BOOT_ROOT
cp -p $SYSTEM_ROOT/usr/share/bootloader/bootcode.bin $BOOT_ROOT
cp -p $SYSTEM_ROOT/usr/share/bootloader/fixup.dat $BOOT_ROOT
cp -p $SYSTEM_ROOT/usr/share/bootloader/start.elf $BOOT_ROOT
[ -f $SYSTEM_ROOT/usr/share/bootloader/dt-blob.bin ] && cp -p $SYSTEM_ROOT/usr/share/bootloader/dt-blob.bin $BOOT_ROOT

rm -f $BOOT_ROOT/bcm283*.dtb # cleanup excess dtb's used by upstream kernels (ie. not LE)
cp -p $SYSTEM_ROOT/usr/share/bootloader/*.dtb $BOOT_ROOT
cp -pR $SYSTEM_ROOT/usr/share/bootloader/overlays $BOOT_ROOT

# cleanup unneeded files
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
fi

# Add distro config file
if [ -f $SYSTEM_ROOT/usr/share/bootloader/distroconfig.txt ]; then
  cp -p $SYSTEM_ROOT/usr/share/bootloader/distroconfig.txt $BOOT_ROOT
fi

# mount $BOOT_ROOT r/o
sync
mount -o remount,ro $BOOT_ROOT
