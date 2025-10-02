# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dool"
PKG_VERSION="1.3.8"
PKG_SHA256="efd8b0889542783cd56b11d08e9b571bfbeaad7a21d9d3c586b1e22ae14be1cd"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/scottchiefbaker/dool"
PKG_URL="https://github.com/scottchiefbaker/dool/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3"
PKG_LONGDESC="Python3 compatible clone of dstat"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-sysroot"

post_unpack() {
  rm ${PKG_BUILD}/Makefile
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p dool ${INSTALL}/usr/bin
  cp -pr plugins ${INSTALL}/usr/bin
  printf "#!/bin/sh\n\necho \"\${0} has been replaced by dool\"" >${INSTALL}/usr/bin/dstat
  chmod 755 ${INSTALL}/usr/bin/dstat
}
