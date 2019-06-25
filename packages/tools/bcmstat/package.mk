# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcmstat"
PKG_VERSION="0.5.2"
PKG_SHA256="55dec681b8dddb3b4d98e339644fa68ff3d0f05d287b09037cbad4d450df7a3a"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/MilhouseVH/bcmstat"
PKG_URL="https://github.com/MilhouseVH/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Raspberry Pi monitoring script"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -PRv bcmstat.sh $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*
}
