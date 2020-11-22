# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libwebsockets"
PKG_VERSION="4.0.7"
PKG_SHA256="531e8f54fb9df64e790a3a62ace103dfbd67d2e3994745623422f89fbb7abcaf"
PKG_LICENSE="LGPL2+"
PKG_SITE="https://libwebsockets.org"
PKG_URL="https://github.com/warmcat/libwebsockets/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl json-c libuv"
PKG_LONGDESC="Library for implementing network protocols with a tiny footprint."

PKG_CMAKE_OPTS_TARGET="-DLWS_WITH_LIBUV=ON \
                       -DLWS_WITHOUT_TESTAPPS=ON"
