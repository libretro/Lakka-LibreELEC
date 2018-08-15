# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.fishbmc"
PKG_VERSION="3dae2bd6dc15dad0131fb31c3b00e41ab1caa0f0"
PKG_SHA256="471765286c6054717980510edf5d49390b0d4f38289c83830a9e0a444202825c"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/notspiff/visualization.fishbmc/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="visualization.fishbmc"
PKG_LONGDESC="visualization.fishbmc"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
