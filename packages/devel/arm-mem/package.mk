# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="arm-mem"
PKG_VERSION="a3277ce"
PKG_SHA256="f571bbc43e3670c8f52447eb885f0c561ed039bcfb692678681899d7df13b165"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/bavison/arm-mem"
PKG_URL="https://github.com/bavison/arm-mem/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_INIT="toolchain arm-mem"
PKG_LONGDESC="arm-mem is a ARM-accelerated versions of selected functions from string.h"
PKG_BUILD_FLAGS="+pic"

if [ "$DEVICE" = "RPi2" -o "$DEVICE" = "Slice3" ] ; then
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
