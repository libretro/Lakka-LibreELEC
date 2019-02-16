# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.stars"
PKG_VERSION="8664bfe8fbe4fcf53798b1e73e49b95742fc1c73"
PKG_SHA256="5abaa43742da3c3bf3f0da99e8d8eb56868e82c09a6275bbd50d985ed647de8c"
PKG_REV="0"
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
