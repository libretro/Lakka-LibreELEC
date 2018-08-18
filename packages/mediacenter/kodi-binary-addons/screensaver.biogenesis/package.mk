# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.biogenesis"
PKG_VERSION="7c2694dfb5891bdfc95b2624235fcb6fceccd7c1"
PKG_SHA256="2502dd6273dc396a5bf9ae6daad5248fdd03571152bffbb67f3b1f762d319f49"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.biogenesis"
PKG_URL="https://github.com/notspiff/screensaver.biogenesis/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.biogenesis"
PKG_LONGDESC="screensaver.biogenesis"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
