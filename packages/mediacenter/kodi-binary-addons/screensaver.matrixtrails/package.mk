# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.matrixtrails"
PKG_VERSION="b9987ca27ffc82919b856164ac91941dda17200a"
PKG_SHA256="89e5c75fff9c3f475d8ce733825acb92020f7c5b53068d69b6952c710f8284d4"
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
