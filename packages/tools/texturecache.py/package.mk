# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="texturecache.py"
PKG_VERSION="2.5.0"
PKG_SHA256="cc0d8fe9a6b71ce1fc93a3317a2d5704f25758c9d48f71e267def765663a770c"
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
