# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="texturecache.py"
PKG_VERSION="2.4.7"
PKG_SHA256="931db4a1626e583a654ab881da4e62856cd457b143a288bca83d38db2621d0cc"
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
