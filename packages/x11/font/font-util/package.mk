# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="font-util"
PKG_VERSION="1.3.1"
PKG_SHA256="aa7ebdb0715106dd255082f2310dbaa2cd7e225957c2a77d719720c7cc92b921"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/font/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_DEPENDS_HOST="util-macros"
PKG_LONGDESC="X.org font utilities."

PKG_CONFIGURE_OPTS_TARGET="--with-mapdir=/usr/share/fonts/util"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
