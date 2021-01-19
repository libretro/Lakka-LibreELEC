# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libaio"
PKG_VERSION="0.3.112"
PKG_SHA256="f69e5800425f4ea957426693ac09f9896bb993db5490fa021644454adcc72a32"
PKG_LICENSE="GPL"
PKG_SITE="http://lse.sourceforge.net/io/aio.html"
PKG_URL="http://http.debian.net/debian/pool/main/liba/libaio/${PKG_NAME}_${PKG_VERSION}.orig.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Kernel Asynchronous I/O (AIO) Support for Linux."

make_target() {
  make -C src
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    cp -PR src/libaio.a ${SYSROOT_PREFIX}/usr/lib

  mkdir -p ${SYSROOT_PREFIX}/usr/include
    cp -PR src/libaio.h ${SYSROOT_PREFIX}/usr/include
}
