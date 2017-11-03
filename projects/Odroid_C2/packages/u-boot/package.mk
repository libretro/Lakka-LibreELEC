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

PKG_NAME="u-boot"
PKG_VERSION="6e4e886"
PKG_SHA256="0d05829e07e226d1acbc6b23ff038d6c92fa3ed738ddc28703d51987c0fab3bb"
PKG_SITE="https://github.com/hardkernel/u-boot"
PKG_URL="https://github.com/hardkernel/u-boot/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain gcc-linaro-aarch64-elf:host gcc-linaro-arm-eabi:host"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project (Hardkernel Fork)"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."
PKG_AUTORECONF="no"

pre_configure_target() {
  if [ -z "$UBOOT_CONFIG" ]; then
    echo "$TARGET_PLATFORM does not define any u-boot configuration, aborting."
    echo "Please add UBOOT_CONFIG to your project options file."
    exit 1
  fi

  unset LDFLAGS

# dont build in parallel because of problems
  MAKEFLAGS=-j1

# copy compiler-gcc5.h to compiler-gcc6. for fake building
  cp include/linux/compiler-gcc5.h include/linux/compiler-gcc6.h
}

make_target() {
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$TOOLCHAIN/lib/gcc-linaro-arm-eabi/bin/:$PATH
  CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make mrproper
  CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make $UBOOT_CONFIG
  CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make HOSTCC="$HOST_CC" HOSTSTRIP="true"
}

makeinstall_target() {
  mkdir -p $TOOLCHAIN/bin
    cp build/tools/mkimage $TOOLCHAIN/bin

  mkdir -p $INSTALL/usr/share/bootloader

  cp $PKG_BUILD/$UBOOT_CONFIGFILE $INSTALL/usr/share/bootloader 2>/dev/null || :

  cp -PRv $PKG_DIR/scripts/update-c2.sh $INSTALL/usr/share/bootloader/update.sh
  cp -PRv $PKG_BUILD/u-boot.bin $INSTALL/usr/share/bootloader/u-boot
  if [ -f $PROJECT_DIR/$PROJECT/splash/boot-logo.bmp.gz ]; then
    cp -PRv $PROJECT_DIR/$PROJECT/splash/boot-logo.bmp.gz $INSTALL/usr/share/bootloader
  elif [ -f $DISTRO_DIR/$DISTRO/splash/boot-logo.bmp.gz ]; then
    cp -PRv $DISTRO_DIR/$DISTRO/splash/boot-logo.bmp.gz $INSTALL/usr/share/bootloader
  fi
}
