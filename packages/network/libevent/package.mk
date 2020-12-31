# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libevent"
PKG_VERSION="2.1.12"
PKG_SHA256="92e6de1be9ec176428fd2367677e61ceffc2ee1cb119035037a27d346b0403bb"
PKG_LICENSE="BSB-3c"
PKG_SITE="https://github.com/libevent/libevent"
PKG_URL="https://github.com/libevent/libevent/releases/download/release-${PKG_VERSION}-stable/libevent-${PKG_VERSION}-stable.tar.gz"
PKG_LONGDESC="Event notification library"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_CXX_EXTENSIONS:BOOL=OFF \
                       -DCMAKE_CXX_STANDARD=14 \
                       -DSPDLOG_BUILD_EXAMPLE=OFF \
                       -DSPDLOG_BUILD_TESTS=OFF \
                       -DSPDLOG_FMT_EXTERNAL=ON"
