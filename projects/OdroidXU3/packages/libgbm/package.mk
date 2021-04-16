# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libgbm"
PKG_VERSION="c2b7a77"
PKG_SHA256="6b7970448fb6ca361daca347490d7d19e0fa8823f11755204fa5e13c91238bb9"
PKG_ARCH="any"
PKG_LICENSE="other"
PKG_SITE="https://github.com/robclark/libgbm"
PKG_URL="https://github.com/robclark/libgbm/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Generic Buffer Manager"
PKG_TOOLCHAIN="manual"

make_target() {
 : # nothing todo
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp -PRv $PKG_BUILD/gbm.h $SYSROOT_PREFIX/usr/include/gbm.h
}

