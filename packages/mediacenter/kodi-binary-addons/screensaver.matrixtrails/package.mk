# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.matrixtrails"
PKG_VERSION="b652e74ad8b2fac66c548393dfc016ee89693318"
PKG_SHA256="1e9d97d2256f4d9e283b182f454a7d707fef29481d32f328bbee411f71318bac"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.matrixtrails"
PKG_URL="https://github.com/notspiff/screensaver.matrixtrails/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform soil"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.matrixtrails"
PKG_LONGDESC="screensaver.matrixtrails"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
