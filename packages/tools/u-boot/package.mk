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
PKG_VERSION="2017.09"
PKG_SHA256="b2d15f2cf5f72e706025cde73d67247c6da8cd35f7e10891eefe7d9095089744"
PKG_ARCH="arm aarch64"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="ftp://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="u-boot-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain dtc:host"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."
PKG_AUTORECONF="no"
PKG_IS_KERNEL_PKG="yes"

make_target() {
  if [ -z "$UBOOT_SYSTEM" ]; then
    echo "UBOOT_SYSTEM must be set to build an image"
    echo "see './scripts/uboot_helper' for more information"
  else
    CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make mrproper
    CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make $($ROOT/$SCRIPTS/uboot_helper $PROJECT $DEVICE $UBOOT_SYSTEM config)
    CROSS_COMPILE="$TARGET_PREFIX" LDFLAGS="" ARCH=arm make HOSTCC="$HOST_CC" HOSTSTRIP="true"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader

    # Only install u-boot.img et al when building a board specific image
    if [ -n "$UBOOT_SYSTEM" ]; then
      if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/install ]; then
        . $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/install
      elif [ -f $PROJECT_DIR/$PROJECT/bootloader/install ]; then
        . $PROJECT_DIR/$PROJECT/bootloader/install
      fi
    fi

    # Always install the update script
    if [ -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/update.sh ]; then
      cp -av $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader/update.sh $INSTALL/usr/share/bootloader
    elif [ -f $PROJECT_DIR/$PROJECT/bootloader/update.sh ]; then
      cp -av $PROJECT_DIR/$PROJECT/bootloader/update.sh $INSTALL/usr/share/bootloader
    fi
}
