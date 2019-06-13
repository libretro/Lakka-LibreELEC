# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lftp"
PKG_VERSION="4.8.4"
PKG_SHA256="4ebc271e9e5cea84a683375a0f7e91086e5dac90c5d51bb3f169f75386107a62"
PKG_LICENSE="GPLv3"
PKG_SITE="http://lftp.yar.ru/"
PKG_URL="http://lftp.yar.ru/ftp/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain readline openssl zlib libidn2"
PKG_LONGDESC="A sophisticated ftp/http client, and a file transfer program supporting a number of network protocols."

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-gnutls \
                           --with-openssl \
                           --with-readline=$SYSROOT_PREFIX/usr \
                           --with-zlib=$SYSROOT_PREFIX/usr"

makeinstall_target() {
  :
}
