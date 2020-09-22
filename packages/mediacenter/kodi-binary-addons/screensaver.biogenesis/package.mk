# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.biogenesis"
PKG_VERSION="2.5.0-Matrix"
PKG_SHA256="bf56384e6956674cd911c52b2807993d0a6e0ffa9623b5a1981a3153911e135a"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/screensaver.biogenesis"
PKG_URL="https://github.com/xbmc/screensaver.biogenesis/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.biogenesis"
PKG_LONGDESC="screensaver.biogenesis"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
