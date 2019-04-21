# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="texturecache.py"
PKG_VERSION="2.5.1"
PKG_SHA256="bb8a7adca58d04a282af5c1ec5cb4c2dc012dda87510cc665ec4ba4ac7bc0cb3"
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
