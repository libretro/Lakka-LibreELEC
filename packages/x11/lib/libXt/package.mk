# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libXt"
PKG_VERSION="1.1.5"
PKG_SHA256="46eeb6be780211fdd98c5109286618f6707712235fdd19df4ce1e6954f349f1a"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11 libSM"
PKG_SECTION="x11/lib"
PKG_SHORTDESC="libxt: X11 toolkit intrinsics library"
PKG_LONGDESC="LibXt provides the X Toolkit Intrinsics, an abstract widget library upon which other toolkits are based. Xt is the basis for many toolkits, including the Athena widgets (Xaw), and LessTif."

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --with-gnu-ld \
                           --enable-malloc0returnsnull"

pre_make_target() {
  make -C util CC=$HOST_CC \
               CFLAGS="$HOST_CFLAGS " \
               LDFLAGS="$HOST_LDFLAGS" \
               makestrs
}
