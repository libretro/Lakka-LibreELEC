################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="u-boot"
PKG_VERSION="a43076c"
PKG_ARCH="arm aarch64"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="https://github.com/BayLibre/u-boot/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="u-boot-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain dtc:host gcc-linaro-aarch64-elf:host gcc-linaro-arm-eabi:host"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."
PKG_IS_KERNEL_PKG="yes"

PKG_NEED_UNPACK="$PROJECT_DIR/$PROJECT/bootloader"
[ -n "$DEVICE" ] && PKG_NEED_UNPACK+=" $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader"

post_unpack() {
  sed -i 's/^#define CONFIG_DDR_CLK.*912/#define CONFIG_DDR_CLK 792/g' $PKG_BUILD/board/amlogic/configs/libretech_cc.h
}

make_target() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$TOOLCHAIN/lib/gcc-linaro-arm-eabi/bin/:$PATH
  CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make mrproper
  CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make $UBOOT_CONFIG
  CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make HOSTCC="$HOST_CC" HOSTSTRIP="true"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader

    # Only install u-boot.img et al when building a board specific image
    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/install ]; then
      . $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/install
    elif [ -f $PROJECT_DIR/$PROJECT/bootloader/install ]; then
      . $PROJECT_DIR/$PROJECT/bootloader/install
    fi

    # Always install the update script
    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/update.sh ]; then
      cp -av $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/update.sh $INSTALL/usr/share/bootloader
    elif [ -f $PROJECT_DIR/$PROJECT/bootloader/update.sh ]; then
      cp -av $PROJECT_DIR/$PROJECT/bootloader/update.sh $INSTALL/usr/share/bootloader
    fi

    cp $PKG_BUILD/fip/u-boot.bin.sd.bin $INSTALL/usr/share/bootloader/u-boot

    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/boot.ini ]; then
      cp -av $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/boot.ini $INSTALL/usr/share/bootloader
    fi

    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/config.ini ]; then
      cp -av $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/config.ini $INSTALL/usr/share/bootloader
    fi
}
