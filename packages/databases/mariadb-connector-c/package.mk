# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mariadb-connector-c"
PKG_VERSION="3.0.2"
PKG_SHA256="f44f436fc35e081db3a56516de9e3bb11ae96838e75d58910be28ddd2bc56d88"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://mariadb.org/"
PKG_URL="https://github.com/MariaDB/mariadb-connector-c/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_SECTION="database"
PKG_SHORTDESC="mariadb-connector: library to conntect to mariadb/mysql database server"
PKG_LONGDESC="mariadb-connector: library to conntect to mariadb/mysql database server"

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
