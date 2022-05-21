# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="sbc"
PKG_VERSION="1.5"
PKG_SHA256="51d4e385237e9d4780c7b20e660e30fb6a7a6d75ca069f1ed630fa6105232aba"
PKG_LICENSE="GPL"
PKG_SITE="http://www.bluez.org/"
PKG_URL="http://www.kernel.org/pub/linux/bluetooth/sbc-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="standalone SBC library"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-tools \
                           --disable-tester"

post_makeinstall_target() {
  # fix static library
  sed -i 's/-lsbc/-lsbc -lbluetooth/' ${SYSROOT_PREFIX}/usr/lib/pkgconfig/sbc.pc
}
