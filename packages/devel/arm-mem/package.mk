# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="arm-mem"
PKG_VERSION="010044568a9691bb375e86a96f7e26495f5c5d6e"
PKG_SHA256="7a73fc64e0c56b2257f3a4d6d0facee078da74a8a98761823ebf266d57381fd5"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/bavison/arm-mem"
PKG_URL="https://github.com/bavison/arm-mem/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain arm-mem"
PKG_LONGDESC="arm-mem is a ARM-accelerated versions of selected functions from string.h"
PKG_BUILD_FLAGS="+pic"

if target_has_feature neon; then
  PKG_LIB_ARM_MEM="libarmmem-v7l.so"
else
  PKG_LIB_ARM_MEM="libarmmem-v6l.so"
fi

PKG_MAKE_OPTS_TARGET="$PKG_LIB_ARM_MEM"

pre_make_target() {
  export CROSS_COMPILE=$TARGET_PREFIX
}

make_init() {
  : # reuse make_target()
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
    cp -P $PKG_LIB_ARM_MEM $INSTALL/usr/lib

  mkdir -p $INSTALL/etc
    echo "/usr/lib/$PKG_LIB_ARM_MEM" >> $INSTALL/etc/ld.so.preload
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/lib
    cp -P $PKG_LIB_ARM_MEM $INSTALL/usr/lib

  mkdir -p $INSTALL/etc
    echo "/usr/lib/$PKG_LIB_ARM_MEM" >> $INSTALL/etc/ld.so.preload
}
