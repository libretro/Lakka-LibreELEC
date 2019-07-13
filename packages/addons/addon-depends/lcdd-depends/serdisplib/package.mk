# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="serdisplib"
PKG_VERSION="1.97.9"
PKG_SHA256="fe82ebe72731e91509083569dfe41a09e21632cc1211cdc4f76274f83ed218fa"
PKG_LICENSE="GPL"
PKG_SITE="http://serdisplib.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb-compat"
PKG_LONGDESC="Library to drive serial/parallel/usb displays with built-in controllers."

PKG_CONFIGURE_OPTS_TARGET="--prefix=$SYSROOT_PREFIX/usr \
                           --bindir=$SYSROOT_PREFIX/usr/bin \
                           --enable-libusb \
                           --disable-libSDL \
                           --with-drivers=all"

pre_configure_target() {
  # serdisplib fails to build in subdirs
  cd $PKG_BUILD
    rmdir .$TARGET_NAME

  # use libusb-config from sysroot
  export ac_cv_path_LIBUSB_CONFIG=$SYSROOT_PREFIX/usr/bin/libusb-config
}

makeinstall_target() {
  # copy necessary libs and headers to build serdisplib support
  # into the driver glcd from lcdproc
  mkdir -p $SYSROOT_PREFIX/usr/include/serdisplib
  cp include/serdisplib/*.h $SYSROOT_PREFIX/usr/include/serdisplib
  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp lib/libserdisp.so* $SYSROOT_PREFIX/usr/lib

  mkdir -p $INSTALL/usr/lib
  cp lib/libserdisp.so* $INSTALL/usr/lib
}
