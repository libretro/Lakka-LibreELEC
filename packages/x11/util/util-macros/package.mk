# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="util-macros"
PKG_VERSION="1.19.2"
PKG_SHA256="d7e43376ad220411499a79735020f9d145fdc159284867e99467e0d771f3e712"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/util/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="X.org autoconf utilities such as M4 macros."

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
