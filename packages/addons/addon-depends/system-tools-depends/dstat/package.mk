# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dstat"
PKG_VERSION="77e9347"
PKG_SHA256="2b2f4ef3a0d1dc6d0a4bc2f54a57ba6f1e278333881a07df7e55aec502a48c7c"
PKG_LICENSE="GPL"
PKG_SITE="http://dag.wiee.rs/home-made/dstat"
PKG_URL="https://github.com/dagwieers/dstat/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3"
PKG_LONGDESC="Versatile resource statistics tool."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-sysroot"

post_unpack() {
  rm $PKG_BUILD/Makefile
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp -p dstat $INSTALL/usr/bin
}
