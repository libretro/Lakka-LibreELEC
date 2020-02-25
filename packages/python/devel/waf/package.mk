# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="waf"
PKG_VERSION="2.0.19"
PKG_SHA256="ba63c90a865a9bcf46926c4e6776f9a3f73d29f33d49b7f61f96bc37b7397cef"
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
