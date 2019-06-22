# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waf"
PKG_VERSION="2.0.15"
PKG_SHA256="34b8156ea375089e1bed5a31acfaff4024f6f3e96f3bee98f801f0c281ad3d2c"
PKG_LICENSE="MIT"
PKG_SITE="https://waf.io"
PKG_URL="https://waf.io/$PKG_NAME-$PKG_VERSION"
PKG_LONGDESC="The Waf build system"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p $PKG_BUILD
    cp $SOURCES/$PKG_NAME/$PKG_SOURCE_NAME $PKG_BUILD/waf
    chmod a+x $PKG_BUILD/waf
}

makeinstall_host() {
  cp -pf waf $TOOLCHAIN/bin/
}
