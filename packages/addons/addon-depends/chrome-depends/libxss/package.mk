# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxss"
PKG_VERSION="1.2.3"
PKG_SHA256="f917075a1b7b5a38d67a8b0238eaab14acd2557679835b154cf2bca576e89bf8"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/libXScrnSaver-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libXext scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension library."
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-malloc0returnsnull"

post_configure_target() {
  libtool_remove_rpath libtool
}
