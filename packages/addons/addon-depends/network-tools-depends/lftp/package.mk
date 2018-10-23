# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lftp"
PKG_VERSION="4.8.3"
PKG_SHA256="de7aee451afaa1aa391f7076b5f602922c2da0e05524a8d8fea413eda83cc78b"
PKG_LICENSE="GPLv3"
PKG_SITE="http://lftp.yar.ru/"
PKG_URL="http://lftp.yar.ru/ftp/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain readline openssl zlib"
PKG_LONGDESC="A sophisticated ftp/http client, and a file transfer program supporting a number of network protocols."

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-gnutls \
                           --with-openssl \
                           --with-readline=$SYSROOT_PREFIX/usr \
                           --with-zlib=$SYSROOT_PREFIX/usr"

makeinstall_target() {
  :
}
