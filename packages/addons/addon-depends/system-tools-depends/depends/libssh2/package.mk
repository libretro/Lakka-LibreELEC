# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libssh2"
PKG_VERSION="1.8.0"
PKG_SHA256="39f34e2f6835f4b992cafe8625073a88e5a28ba78f83e8099610a7b3af4676d4"
PKG_LICENSE="BSD"
PKG_SITE="https://www.libssh2.org"
PKG_URL="https://www.libssh2.org/download/libssh2-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_LONGDESC="A library implementing the SSH2 protocol"

PKG_CMAKE_OPTS_TARGET="-DBUILD_EXAMPLES=OFF \
                       -DBUILD_TESTING=OFF"
