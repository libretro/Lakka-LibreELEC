# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="nss-mdns"
PKG_VERSION="47edc38"
PKG_SHA256="f02e8baeceea30e82a2ecdaa8cafdbcabfdaa33a766f6942e7dc8aa81948f7b6"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lathiat/nss-mdns"
PKG_URL="https://github.com/lathiat/nss-mdns/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain avahi"
PKG_LONGDESC="A plugin for nss to allow name resolution via Multicast DNS."
PKG_TOOLCHAIN="autotools"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc
  cp $PKG_DIR/config/nsswitch.conf $INSTALL/etc/nsswitch.conf
}
