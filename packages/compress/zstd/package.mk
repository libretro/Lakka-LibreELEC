# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="zstd"
PKG_VERSION="1.3.5"
PKG_SHA256="d6e1559e4cdb7c4226767d4ddc990bff5f9aab77085ff0d0490c828b025e2eea"
PKG_ARCH="any"
PKG_LICENSE="BSD/GPLv2"
PKG_SITE="http://www.zstd.net"
PKG_URL="https://github.com/facebook/zstd/archive/v${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR=$PKG_NAME-$PKG_VERSION
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="compress"
PKG_SHORTDESC="fast real-time compression algorithm"


PKG_CMAKE_SCRIPT="$PKG_BUILD/build/cmake/CMakeLists.txt"
PKG_CMAKE_OPTS_HOST="-DTHREADS_PTHREAD_ARG=0"
