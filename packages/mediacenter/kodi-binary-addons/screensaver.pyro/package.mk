# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensaver.pyro"
PKG_VERSION="ba10e00a9ed7e94c5ee301a26d304fb4d9b934c4"
PKG_SHA256="f1af37ddffcf9bd895c707f1a3125d3d16c3d8585600f83e3c841095798f39a3"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/screensaver.pyro"
PKG_URL="https://github.com/notspiff/screensaver.pyro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.pyro"
PKG_LONGDESC="screensaver.pyro"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
