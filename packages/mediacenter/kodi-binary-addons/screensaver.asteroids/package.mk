# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asteroids"
PKG_VERSION="cc5facbe57c0a504ff768637c43a3191ffc0483b"
PKG_SHA256="88e098f34cad16d19262d46b99871f6fdcb04c13bfb057f1c5abd1eb2d647ba7"
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
