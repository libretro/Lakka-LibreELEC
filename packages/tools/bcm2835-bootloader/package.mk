# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="8c7c52466505df5d420a5cb9131ec29205bcecf8"
PKG_SHA256="ebf23536b4a9d6b8d2ab3924ac73b66bc913aa39b477cb23cdf763e8c55b5ec3"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="https://github.com/raspberrypi/firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux bcmstat"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
    cd boot
    cp -PRv LICENCE* $INSTALL/usr/share/bootloader
    cp -PRv bootcode.bin $INSTALL/usr/share/bootloader
    if [ "$DEVICE" = "RPi4" ]; then
      cp -PRv fixup4x.dat $INSTALL/usr/share/bootloader/fixup.dat
      cp -PRv fixup4.dat $INSTALL/usr/share/bootloader/fixup4.dat
      cp -PRv start4x.elf $INSTALL/usr/share/bootloader/start.elf
    else
      cp -PRv fixup_x.dat $INSTALL/usr/share/bootloader/fixup.dat
      cp -PRv start_x.elf $INSTALL/usr/share/bootloader/start.elf
      cp -PRv fixup4.dat $INSTALL/usr/share/bootloader/fixup4.dat
    fi

    find_file_path config/dt-blob.bin && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader

    find_file_path bootloader/update.sh && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader
    find_file_path bootloader/canupdate.sh && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader

    find_file_path config/distroconfig.txt $PKG_DIR/files/3rdparty/bootloader/distroconfig.txt && cp -PRv ${FOUND_PATH} $INSTALL/usr/share/bootloader
    find_file_path config/config.txt $PKG_DIR/files/3rdparty/bootloader/config.txt && cp -PRv ${FOUND_PATH} $INSTALL/usr/share/bootloader

    # Enable 64-bit mode if ARCH is aarch64 and set kernel name
    if [ "$ARCH" = "aarch64" ]; then
      echo "arm_64bit=1" >> $INSTALL/usr/share/bootloader/distroconfig.txt
      echo "kernel=kernel.img" >> $INSTALL/usr/share/bootloader/distroconfig.txt
    fi
}
