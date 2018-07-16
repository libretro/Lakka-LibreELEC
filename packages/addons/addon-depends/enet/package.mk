# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="enet"
PKG_VERSION="e33ca1d"
PKG_SHA256="0ba5547de2c4c7fc79d367179a9bc92a7ac27e9258dd50fb277cd8761afaf9b0"
PKG_ARCH="any"
PKG_LICENSE=""
PKG_SITE="https://github.com/cgutman/enet/"
PKG_URL="https://github.com/cgutman/enet/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network"
PKG_SHORTDESC="ENet's purpose is to provide a relatively thin, simple and robust network communication layer on top of UDP (User Datagram Protocol)"
PKG_LONGDESC="ENet's purpose is to provide a relatively thin, simple and robust network communication layer on top of UDP (User Datagram Protocol)"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"

post_makeinstall_target() {
  rm -r $INSTALL
}
