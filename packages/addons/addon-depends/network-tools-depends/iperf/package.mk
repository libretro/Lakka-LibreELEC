# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="iperf"
PKG_VERSION="3.10.1"
PKG_SHA256="6a4bb4d5c124b3fa64dfbda469ab16857ad6565310bcaa3dd8cd32f96c2fc473"
PKG_LICENSE="BSD"
PKG_SITE="http://software.es.net/iperf/"
PKG_URL="https://github.com/esnet/iperf/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_LONGDESC="A tool to measuring maximum TCP and UDP bandwidth performance."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared"
