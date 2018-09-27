# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcmstat"
PKG_VERSION="0.5.0"
PKG_SHA256="d18cc53adb7cb4b51137fec533d51b95e4c37b836a8afe20e0d8f02137136cb7"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/MilhouseVH/bcmstat"
PKG_URL="https://github.com/MilhouseVH/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_SECTION="tools"
PKG_LONGDESC="Raspberry Pi monitoring script"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -PRv bcmstat.sh $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*
}
