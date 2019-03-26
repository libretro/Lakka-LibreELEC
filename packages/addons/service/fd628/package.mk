# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fd628"
PKG_VERSION="1.1"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="fd628: Kodi service to light up additional icons on devices with FD628 display"
PKG_LONGDESC="fd628: Kodi service to light up additional icons on devices with FD628 display"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="service.fd628"
PKG_ADDON_PROJECTS="S905 S912"
PKG_ADDON_TYPE="xbmc.service"

make_target() {
  sed -e "s|@PKG_VERSION@|$PKG_VERSION|g" \
      -i addon.xml
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -R $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
}
