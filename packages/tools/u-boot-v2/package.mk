################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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
PKG_NAME="u-boot-v2"
PKG_VERSION="2017.01"
PKG_SITE=""
PKG_URL="ftp://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="u-boot-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  if [ -z "$UBOOT_CONFIG_V2" ]; then
    echo "$TARGET_PLATFORM does not define any u-boot configuration, aborting."
    echo "Please add UBOOT_CONFIG_V2 to your project options file."
    exit 1
  fi

# dont build in parallel because of problems
  #MAKEFLAGS=-j1
# hide compile line
  KBUILD_VERBOSE=0
}

make_target() {
  # get number of targets to build
  UBOOT_TARGET_CNT=0
  for UBOOT_TARGET in $UBOOT_CONFIG_V2; do
    UBOOT_TARGET_CNT=$((UBOOT_TARGET_CNT + 1))
  done

  # renamed files must be in subfolder or they got removed
  rm -fr tmp_output
  mkdir tmp_output

  for UBOOT_TARGET in $UBOOT_CONFIG_V2; do
    echo "$PKG_NAME: building $UBOOT_TARGET"
    make CROSS_COMPILE="$TARGET_PREFIX" CFLAGS="" LDFLAGS="" ARCH=arm mrproper
    make CROSS_COMPILE="$TARGET_PREFIX" CFLAGS="" LDFLAGS="" ARCH=arm $UBOOT_TARGET
    make CROSS_COMPILE="$TARGET_PREFIX" CFLAGS="" LDFLAGS="" ARCH=arm HOSTCC="$HOST_CC" HOSTSTRIP="true"

    # rename files in case of multiple targets
    if [ $UBOOT_TARGET_CNT -gt 1 ]; then
      if [ "$UBOOT_TARGET" = "udoo_config" ]; then
        TARGET_NAME="udoo"
      elif [ "$UBOOT_TARGET" = "tbs2910_config" ]; then
        TARGET_NAME="matrix"
      elif [ "$UBOOT_TARGET" = "wandboard_config" ]; then
        TARGET_NAME="wandboard"
      else
        TARGET_NAME="undef"
      fi

      [ -f u-boot.img ] && mv u-boot.img tmp_output/u-boot-$TARGET_NAME.img || : #
      [ -f u-boot.imx ] && mv u-boot.imx tmp_output/u-boot-$TARGET_NAME.imx || : #
      [ -f SPL ] && mv SPL tmp_output/SPL-$TARGET_NAME || : #
    fi
  done

  mv tmp_output/* .
  rmdir tmp_output
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader

  cp $PKG_BUILD/u-boot-*.imx $INSTALL/usr/share/bootloader 2>/dev/null || : #
  cp $PKG_BUILD/u-boot-*.img $INSTALL/usr/share/bootloader 2>/dev/null || : #
  cp $PKG_BUILD/SPL-* $INSTALL/usr/share/bootloader 2>/dev/null || : #
}

pre_install() {
  # rename tbs matrix binary in main u-boot
  U_BOOT_MAIN_DIR="$(get_build_dir u-boot)"
  if [ -f "$U_BOOT_MAIN_DIR/u-boot-matrix.imx" ]; then
    mv "$U_BOOT_MAIN_DIR/u-boot-matrix.imx" "$U_BOOT_MAIN_DIR/u-boot-matrix-v1.imx" || : #
  fi

  U_BOOT_MAIN_DIR="$U_BOOT_MAIN_DIR/.install_pkg/usr/share/bootloader"
  if [ -f "$U_BOOT_MAIN_DIR/u-boot-matrix.imx" ]; then
    mv "$U_BOOT_MAIN_DIR/u-boot-matrix.imx" "$U_BOOT_MAIN_DIR/u-boot-matrix-v1.imx" || : #
  fi
}
