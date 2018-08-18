# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.asterwave"
PKG_VERSION="5bb1c48074a6cdcd7819afe2ad07cdc7915ced44"
PKG_SHA256="1213695199587155d9f46a7c96586ee46cebfb1b5d373c1b1e2ba77de19381af"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.asterwave"
PKG_URL="https://github.com/notspiff/screensaver.asterwave/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform soil"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.asterwave"
PKG_LONGDESC="screensaver.asterwave"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
