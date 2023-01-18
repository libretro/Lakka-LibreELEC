# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libzip"
PKG_VERSION="1.9.2"
PKG_SHA256="c93e9852b7b2dc931197831438fee5295976ee0ba24f8524a8907be5c2ba5937"
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
  rm -rf ${INSTALL}/usr/lib
}
