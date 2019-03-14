# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.stars"
PKG_VERSION="2.1.1-Leia"
PKG_SHA256="a0b644d6f7ba3ad51765c176f7f6e52a6bccd0958bfbec3051d8a81591de2c43"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.stars"
PKG_URL="https://github.com/xbmc/screensaver.stars/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.stars"
PKG_LONGDESC="screensaver.stars"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
