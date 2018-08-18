# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.pingpong"
PKG_VERSION="a702c1b15ec92845302e1cfcad6e2f7d054bdeb0"
PKG_SHA256="80eb9b0f1292fa9eebe7dfc8843c859b5c1c05c59704ef1d53c88ba87519a153"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.pingpong"
PKG_URL="https://github.com/notspiff/screensaver.pingpong/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.pingpong"
PKG_LONGDESC="screensaver.pingpong"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
