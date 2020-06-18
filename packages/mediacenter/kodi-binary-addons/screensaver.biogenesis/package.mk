# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.biogenesis"
PKG_VERSION="2.2.3-Leia"
PKG_SHA256="b0f721d112282f633a769e7b077c5dd52e5045a8f1ae32c4e602b0e2e937acb0"
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
