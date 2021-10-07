# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mariadb-connector-c"
PKG_VERSION="3.1.13"
PKG_SHA256="361136e9c365259397190109d50f8b6a65c628177792273b4acdb6978942b5e7"
PKG_LICENSE="LGPL"
PKG_SITE="https://mariadb.org/"
PKG_URL="https://github.com/MariaDB/mariadb-connector-c/archive/v${PKG_VERSION}.tar.gz"
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
  rm -rf ${INSTALL}/usr
}
