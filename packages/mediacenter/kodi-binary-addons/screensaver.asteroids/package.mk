# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asteroids"
PKG_VERSION="73fff6daf59e2a2455d10be93080457a30ba5516"
PKG_SHA256="079203678c0dddcc5d4797ff3587b9499ae7b78fd18b4a76de81e60b80daa898"
PKG_REV="0"
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
