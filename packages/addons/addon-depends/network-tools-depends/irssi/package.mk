# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="irssi"
PKG_VERSION="1.2.3"
PKG_SHA256="a647bfefed14d2221fa77b6edac594934dc672c4a560417b1abcbbc6b88d769f"
PKG_LICENSE="GPL"
PKG_SITE="http://www.irssi.org/"
PKG_URL="https://github.com/irssi/irssi/releases/download/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib ncurses openssl"
PKG_LONGDESC="Irssi is a terminal based IRC client for UNIX systems."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=${SYSROOT_PREFIX} \
        --disable-glibtest \
        --without-socks \
        --with-textui \
        --without-bot \
        --without-proxy \
        --without-perl"

pre_configure_target() {
  export CFLAGS="${CFLAGS} -I${PKG_BUILD}"
}
