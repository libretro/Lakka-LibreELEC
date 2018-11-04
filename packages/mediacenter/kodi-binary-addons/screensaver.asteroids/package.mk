# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asteroids"
PKG_VERSION="65d5db733fcc199e949f660639e423c16823c0ba"
PKG_SHA256="dcd8220bc2bd26bbe6d52b1b12ac05b304e238fe023e41abe4d7b519bd07172f"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.asteroids"
PKG_URL="https://github.com/xbmc/screensaver.asteroids/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.asteroids"
PKG_LONGDESC="screensaver.asteroids"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
