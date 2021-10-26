# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mariadb-connector-c"
PKG_VERSION="3.1.14"
PKG_SHA256="2615f0824c467097818e54809516f249ced4152f2536cded152227f883222a8e"
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
  # keep modern authentication plugins
  PLUGINP=${INSTALL}/usr/lib/mariadb/plugin
  mkdir -p ${INSTALL}/.tmp
  mv ${PLUGINP}/{caching_sha2_password,client_ed25519,sha256_password}.so ${INSTALL}/.tmp

  # drop all unneeded
  rm -rf ${INSTALL}/usr

  mkdir -p ${PLUGINP}
  mv ${INSTALL}/.tmp/* ${PLUGINP}/
  rmdir ${INSTALL}/.tmp
}
