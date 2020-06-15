# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.matrixtrails"
PKG_VERSION="2.2.3-Leia"
PKG_SHA256="5a2f5bca0c197eea87f06376941c6d0ddbc81cf144d8c3854ac148fdec3400ec"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.matrixtrails"
PKG_URL="https://github.com/xbmc/screensaver.matrixtrails/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform soil"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.matrixtrails"
PKG_LONGDESC="screensaver.matrixtrails"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
