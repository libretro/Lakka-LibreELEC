# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="zstd"
PKG_VERSION="1.3.8"
PKG_SHA256="293fa004dfacfbe90b42660c474920ff27093e3fb6c99f7b76e6083b21d6d48e"
PKG_LICENSE="BSD/GPLv2"
PKG_SITE="http://www.zstd.net"
PKG_URL="https://github.com/facebook/zstd/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR=$PKG_NAME-$PKG_VERSION
PKG_DEPENDS_HOST="gcc:host ninja:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fast real-time compression algorithm."

configure_package() {
  PKG_CMAKE_SCRIPT="$PKG_BUILD/build/cmake/CMakeLists.txt"
  PKG_CMAKE_OPTS_HOST="-DTHREADS_PTHREAD_ARG=0"
}
