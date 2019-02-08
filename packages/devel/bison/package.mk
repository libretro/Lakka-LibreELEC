# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bison"
PKG_VERSION="3.0.5"
PKG_SHA256="075cef2e814642e30e10e8155e93022e4a91ca38a65aa1d5467d4e969f97f338"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/bison/"
PKG_URL="http://ftpmirror.gnu.org/bison/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host m4:host"
PKG_LONGDESC="A general-purpose parser generator."

PKG_CONFIGURE_OPTS_HOST="--disable-rpath --with-gnu-ld"

post_configure_host() {
# The configure system causes Bison to be built without support for
# internationalization of error messages if a bison program is not already in
# $PATH. The following addition will correct this:
  echo '#define YYENABLE_NLS 1' >> lib/config.h
}
