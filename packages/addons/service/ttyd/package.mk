# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ttyd"
PKG_VERSION="1.4.4"
PKG_SHA256="b910a33ddaa474c369991ba345187a8a2f4aa420389083671ba3a6c305a491d6"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/tsl0922/ttyd"
PKG_URL="https://github.com/tsl0922/ttyd/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libwebsockets"
PKG_SECTION="service"
PKG_SHORTDESC="ttyd: a tool for accessing the terminal over a browser"
PKG_LONGDESC="ttyd ($PKG_VERSION): is a simple command-line tool for sharing terminal over the web"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Web SSH Terminal"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.install_pkg/usr/bin/ttyd $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -p $(get_build_dir json-c)/.install_pkg/usr/lib/libjson-c.so $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -p $(get_build_dir libwebsockets)/.install_pkg/usr/lib/libwebsockets.so.14 $ADDON_BUILD/$PKG_ADDON_ID/lib
}
