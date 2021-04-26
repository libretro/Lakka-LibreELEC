# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmicrohttpd"
PKG_VERSION="0.9.73"
PKG_SHA256="a37b2f1b88fd1bfe74109586be463a434d34e773530fc2a74364cfcf734c032e"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="http://www.gnu.org/software/libmicrohttpd/"
PKG_URL="http://ftpmirror.gnu.org/libmicrohttpd/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain gnutls"
PKG_LONGDESC="A small C library that is supposed to make it easy to run an HTTP server as part of another application."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-curl \
                           --enable-https"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
}
