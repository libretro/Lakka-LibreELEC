# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019 Trond Haugland (trondah@gmail.com)

PKG_NAME="u-boot"
PKG_DEPENDS_TARGET="toolchain"
PKG_VERSION="88af53fb"
PKG_SHA256="e546581f805084d3939005b446d8b38df91e0364f844c7c0176e840f64570199"
PKG_SITE="https://github.com/hardkernel/u-boot/tree/odroidxu4-v2017.05"
PKG_URL="https://github.com/hardkernel/u-boot/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dtc:host"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_BUILD_FLAGS="-parallel"

post_patch() {
  if find_file_path bootloader/config; then
    cat $FOUND_PATH >> "$PKG_BUILD/configs/$UBOOT_CONFIG"
  fi
}

make_target() {
  export TOOLCHAIN
  make CROSS_COMPILE="$TARGET_PREFIX" ARCH=arm mrproper
  make CROSS_COMPILE="$TARGET_PREFIX" ARCH=arm $UBOOT_CONFIG
  make CROSS_COMPILE="$TARGET_PREFIX" ARCH=arm HOSTCC="$HOST_CC" HOSTSTRIP="true"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
  find_file_path bootloader/update.sh && cp ${FOUND_PATH} $INSTALL/usr/share/bootloader
}
