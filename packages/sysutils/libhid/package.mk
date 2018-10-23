# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libhid"
PKG_VERSION="0.2.16"
PKG_SHA256="f6809ab3b9c907cbb05ceba9ee6ca23a705f85fd71588518e14b3a7d9f2550e5"
PKG_LICENSE="GPL"
PKG_SITE="http://libhid.alioth.debian.org/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb-compat libusb"
PKG_LONGDESC="libhid provides a generic and flexible way to access and interact with USB HID devices."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
            --enable-static \
            --disable-werror \
            --disable-swig"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
