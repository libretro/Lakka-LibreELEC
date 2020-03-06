# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="texturecache.py"
PKG_VERSION="2.5.3"
PKG_SHA256="19db4f96db4ba891c2ddc5b746e0b9b42eab4e1be0bdf0b2a4eea9b2e4d6aa73"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/MilhouseVH/texturecache.py"
PKG_URL="https://github.com/MilhouseVH/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="The Swiss Army knife for Kodi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -PRv texturecache.py $INSTALL/usr/bin
    cp -PRv tools/mklocal.py $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*
}
