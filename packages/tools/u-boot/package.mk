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
PKG_DEPENDS_TARGET="toolchain"
if [ "$UBOOT_VERSION" = "imx6-cuboxi" ]; then
  PKG_COMMIT="ad02f49"
  PKG_VERSION="imx6-$PKG_COMMIT"
  PKG_SHA256="bee9c8f4d21230a53605ed0df2ee79a9d2a18a49870d235ec0993a26a37ba0fd"
  PKG_SITE="http://solid-run.com/wiki/doku.php?id=products:imx6:software:development:u-boot"
  PKG_URL="https://github.com/SolidRun/u-boot-imx6/archive/$PKG_COMMIT.tar.gz"
  PKG_SOURCE_NAME="$PKG_NAME-sr-$PKG_VERSION.tar.gz"
  PKG_SOURCE_DIR="$PKG_NAME-imx6-${PKG_COMMIT}*"
  [ -n "$UBOOT_CONFIG_V2" ] && PKG_DEPENDS_TARGET="toolchain u-boot-v2"
else
  exit 0
fi
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."
PKG_AUTORECONF="no"

pre_configure_target() {
  if [ -z "$UBOOT_CONFIG" ]; then
    echo "$TARGET_PLATFORM does not define any u-boot configuration, aborting."
    echo "Please add UBOOT_CONFIG to your project options file."
    exit 1
  fi

  if [ -z "$UBOOT_CONFIGFILE" ]; then
    UBOOT_CONFIGFILE="boot.scr"
  fi

  unset LDFLAGS

# dont build in parallel because of problems
  MAKEFLAGS=-j1

# copy compiler-gcc5.h to compiler-gcc6. for fake building
  cp include/linux/compiler-gcc5.h include/linux/compiler-gcc6.h
}

make_target() {
  # get number of targets to build
  UBOOT_TARGET_CNT=0
  for UBOOT_TARGET in $UBOOT_CONFIG; do
    UBOOT_TARGET_CNT=$((UBOOT_TARGET_CNT + 1))
  done

  for UBOOT_TARGET in $UBOOT_CONFIG; do
    make CROSS_COMPILE="$TARGET_PREFIX" ARCH=arm mrproper
    make CROSS_COMPILE="$TARGET_PREFIX" ARCH=arm $UBOOT_TARGET
    make CROSS_COMPILE="$TARGET_PREFIX" ARCH=arm HOSTCC="$HOST_CC" HOSTSTRIP="true"

    # rename files in case of multiple targets
    if [ $UBOOT_TARGET_CNT -gt 1 ]; then
      if [ "$UBOOT_TARGET" = "mx6_cubox-i_config" ]; then
        TARGET_NAME="cuboxi"
      elif [ "$UBOOT_TARGET" = "matrix" ]; then
        TARGET_NAME="matrix"
      elif [ "$UBOOT_TARGET" = "udoo_config" ]; then
        TARGET_NAME="udoo"
      else
        TARGET_NAME="undef"
      fi

      [ -f u-boot.img ] && mv u-boot.img u-boot-$TARGET_NAME.img || :
      [ -f u-boot.imx ] && mv u-boot.imx u-boot-$TARGET_NAME.imx || :
      [ -f SPL ] && mv SPL SPL-$TARGET_NAME || :
    fi
  done
}

makeinstall_target() {
  mkdir -p $TOOLCHAIN/bin
    if [ -f build/tools/mkimage ]; then
      cp build/tools/mkimage $TOOLCHAIN/bin
    else
      cp tools/mkimage $TOOLCHAIN/bin
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

  cp $PKG_BUILD/u-boot*.imx $INSTALL/usr/share/bootloader 2>/dev/null || :
  cp $PKG_BUILD/u-boot*.img $INSTALL/usr/share/bootloader 2>/dev/null || :
  cp $PKG_BUILD/SPL* $INSTALL/usr/share/bootloader 2>/dev/null || :

  cp $PKG_BUILD/$UBOOT_CONFIGFILE $INSTALL/usr/share/bootloader 2>/dev/null || :

  cp -PR $PROJECT_DIR/$PROJECT/bootloader/uEnv*.txt $INSTALL/usr/share/bootloader 2>/dev/null || :

}
