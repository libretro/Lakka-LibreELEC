# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="ce9911cefc825c43c867b7dbb3a53be0974db5d4"
PKG_SHA256="5b19ab4cbbbcf634575c344b076f1fc3c9f9d11fe14779a5bd85db3e72bb6457"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux bcmstat"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
    cp -PRv LICENCE* $INSTALL/usr/share/bootloader
    cp -PRv bootcode.bin $INSTALL/usr/share/bootloader
    if [ "$DEVICE" = "RPi4" ]; then
      cp -PRv fixup4x.dat $INSTALL/usr/share/bootloader/fixup.dat
      cp -PRv start4x.elf $INSTALL/usr/share/bootloader/start.elf
    else
      cp -PRv fixup_x.dat $INSTALL/usr/share/bootloader/fixup.dat
      cp -PRv start_x.elf $INSTALL/usr/share/bootloader/start.elf
    fi

    find_file_path config/dt-blob.bin && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader

    find_file_path bootloader/update.sh && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader
    find_file_path bootloader/canupdate.sh && cp -PRv $FOUND_PATH $INSTALL/usr/share/bootloader

    find_file_path config/distroconfig.txt $PKG_DIR/files/3rdparty/bootloader/distroconfig.txt && cp -PRv ${FOUND_PATH} $INSTALL/usr/share/bootloader
    find_file_path config/config.txt $PKG_DIR/files/3rdparty/bootloader/config.txt && cp -PRv ${FOUND_PATH} $INSTALL/usr/share/bootloader
}
