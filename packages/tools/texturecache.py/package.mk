# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="texturecache.py"
PKG_VERSION="2.4.9"
PKG_SHA256="33e9f5faf07298a7da4136ac8f2a9310d486b267b3931b271070518b36ff9865"
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
