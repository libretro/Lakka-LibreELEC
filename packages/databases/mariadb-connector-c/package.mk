# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mariadb-connector-c"
PKG_VERSION="3.1.1"
PKG_SHA256="63a0ecfa3c87ba0361aef3b2c849abe280f7371030e84f41ce0dc4466db85637"
PKG_LICENSE="LGPL"
PKG_SITE="https://mariadb.org/"
PKG_URL="https://github.com/MariaDB/mariadb-connector-c/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="mariadb-connector: library to conntect to mariadb/mysql database server"
PKG_BUILD_FLAGS="-gold"

PKG_CMAKE_OPTS_TARGET="-DWITH_EXTERNAL_ZLIB=ON
                       -DAUTH_CLEARTEXT=STATIC
                       -DAUTH_DIALOG=STATIC
                       -DAUTH_OLDPASSWORD=STATIC
                       -DREMOTEIO=OFF
                      "

post_makeinstall_target() {
  # drop all unneeded
  rm -rf $INSTALL/usr
}
