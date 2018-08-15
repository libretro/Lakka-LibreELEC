# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.stars"
PKG_VERSION="530cf20c49fb8b0f3556c4a3f16d079d71f8c7f9"
PKG_SHA256="a1b9da2425be6dbf36a7218f66462656610dda8f644e9c497a0a93e2571cb5db"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.stars"
PKG_URL="https://github.com/notspiff/screensaver.stars/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.stars"
PKG_LONGDESC="screensaver.stars"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
