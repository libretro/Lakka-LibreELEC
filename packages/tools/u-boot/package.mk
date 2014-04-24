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

PKG_NAME="u-boot"
if [ "$UBOOT_VERSION" = "default" ]; then
  PKG_VERSION="2011.03-rc1"
  PKG_SITE="http://www.denx.de/wiki/U-Boot/WebHome"
  PKG_URL="ftp://ftp.denx.de/pub/u-boot/$PKG_NAME-$PKG_VERSION.tar.bz2"
elif [ "$UBOOT_VERSION" = "imx6-cuboxi" ]; then
  PKG_VERSION="imx6-ed888a1"
  PKG_SITE="http://imx.solid-run.com/wiki/index.php?title=Building_the_kernel_and_u-boot_for_the_CuBox-i_and_the_HummingBoard"
  PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
fi
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  if [ -z "$UBOOT_CONFIG" ]; then
    echo "$TARGET_PLATFORM does not define any u-boot configuration, aborting."
    echo "Please add MACHINE_UBOOT_CONFIG to your platform meta file"
    exit 1
  fi

  if [ -z "$UBOOT_CONFIGFILE" ]; then
    UBOOT_CONFIGFILE="boot.scr"
  fi

  unset LDFLAGS

# dont use some optimizations because of problems
  MAKEFLAGS=-j1
}

make_target() {
  make CROSS_COMPILE="$TARGET_PREFIX" ARCH="$TARGET_ARCH" $UBOOT_CONFIG
  make CROSS_COMPILE="$TARGET_PREFIX" ARCH="$TARGET_ARCH" HOSTCC="$HOST_CC" HOSTSTRIP="true"
}

makeinstall_target() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    if [ -f build/tools/mkimage ]; then
      cp build/tools/mkimage $ROOT/$TOOLCHAIN/bin
    else
      cp tools/mkimage $ROOT/$TOOLCHAIN/bin
    fi

  BOOT_CFG="$PROJECT_DIR/$PROJECT/bootloader/boot.cfg"
  if [ -r "$BOOT_CFG" ]; then
    cp $BOOT_CFG boot.cfg
    mkimage -A "$TARGET_ARCH" \
            -O u-boot \
            -T script \
            -C none \
            -n "$DISTRONAME Boot" \
            -d boot.cfg \
            $UBOOT_CONFIGFILE
  fi

  mkdir -p $INSTALL/usr/share/bootloader
    cp ./u-boot.bin $INSTALL/usr/share/bootloader

  if [ -f "./u-boot.img" ]; then
    cp ./u-boot.img $INSTALL/usr/share/bootloader
  fi

  if [ -f "./MLO" ]; then
    cp ./MLO $INSTALL/usr/share/bootloader
  fi

  if [ -f "./SPL" ]; then
    cp ./SPL $INSTALL/usr/share/bootloader
  fi

  if [ -f "./boot.cfg" ]; then
    cp ./boot.cfg $INSTALL/usr/share/bootloader
  fi

  if [ -f "./$UBOOT_CONFIGFILE" ]; then
    cp ./$UBOOT_CONFIGFILE $INSTALL/usr/share/bootloader
  fi

  for config in $PROJECT_DIR/$PROJECT/bootloader/*; do
    cp -PR $config $INSTALL/usr/share/bootloader
  done
}
