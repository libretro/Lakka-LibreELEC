# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.greynetic"
PKG_VERSION="4e8cca51277ce17f35210f28fbaa0d0057787850"
PKG_SHA256="e27a72abec73fc365a12352b7c689b363aca3c5e9824bb13a530f3468cf8889f"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.greynetic"
PKG_URL="https://github.com/xbmc/screensaver.greynetic/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.greynetic"
PKG_LONGDESC="screensaver.greynetic"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
