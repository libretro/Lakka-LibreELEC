# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libimobiledevice"
PKG_VERSION="1.2.0"
PKG_SHA256="786b0de0875053bf61b5531a86ae8119e320edab724fc62fe2150cc931f11037"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="http://www.libimobiledevice.org/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusbmuxd openssl"
PKG_LONGDESC="A cross-platform software library that talks the protocols to support Apple devices."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --without-cython \
                           --disable-largefile"

post_makeinstall_target() {
  mkdir -p "${SYSROOT_PREFIX}/usr/include/lib/libimobiledevice"
    cp ${PKG_BUILD}/common/utils.h "${SYSROOT_PREFIX}/usr/include/libimobiledevice"
}
