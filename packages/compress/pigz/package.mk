# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pigz"
PKG_VERSION="2.4"
PKG_SHA256="e228e7d18b34c4ece8d596eb6eee97bde533c6beedbb728d07d3abe90b4b1b52"
PKG_LICENSE="Other"
PKG_SITE="https://zlib.net/pigz/"
PKG_URL="https://github.com/madler/pigz/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="make:host zlib:host"
PKG_LONGDESC="a parallel implementation of the gzip file compressor"
PKG_TOOLCHAIN="manual"

make_host() {
  make CPPFLAGS="${CPPFLAGS} -I${TOOLCHAIN}/include" \
       LDFLAGS="${LDFLAGS}" \
       CXX="${CXX}" \
       CC="${CC}" \
       pigz
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp pigz ${TOOLCHAIN}/bin
}
