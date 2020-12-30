# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libzip"
PKG_VERSION="1.7.3"
PKG_SHA256="a60473ffdb7b4260c08bfa19c2ccea0438edac11193c3afbbb1f17fbcf6c6132"
PKG_LICENSE="GPL"
PKG_SITE="https://libzip.org/"
PKG_URL="https://libzip.org/download/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib bzip2"
PKG_LONGDESC="A C library for reading, creating, and modifying zip archives."

PKG_CMAKE_OPTS_TARGET="-DENABLE_COMMONCRYPTO=OFF \
                       -DENABLE_GNUTLS=OFF \
                       -DENABLE_MBEDTLS=OFF \
                       -DENABLE_OPENSSL=OFF \
                       -DENABLE_WINDOWS_CRYPTO=OFF \
                       -DBUILD_TOOLS=OFF \
                       -DBUILD_REGRESS=OFF \
                       -DBUILD_EXAMPLES=OFF \
                       -DBUILD_DOC=OFF \
                       -DBUILD_SHARED_LIBS=OFF"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib
}
