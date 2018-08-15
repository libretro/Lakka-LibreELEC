# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.greynetic"
PKG_VERSION="6aefc4bb9f1da4179d98f55a3664bd2fc8f67c4a"
PKG_SHA256="b23ff0b2db842eebb58c147057ac835184f121c065ce0d33c2d03534ea95d28f"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.greynetic"
PKG_URL="https://github.com/notspiff/screensaver.greynetic/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.greynetic"
PKG_LONGDESC="screensaver.greynetic"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
