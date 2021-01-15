# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.matrix"
PKG_VERSION="f35fef1752a8544ce76e4649e480bd24f3eac4db"
PKG_SHA256="20ceaa89ed55a3513154a77db7b14eb37e1fa6c30556ff0b5c3f4ad6450caa9e"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/visualization.matrix"
PKG_URL="https://github.com/xbmc/visualization.matrix/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform glm"
PKG_SECTION=""
PKG_LONGDESC="visualization.matrix"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ ! "$OPENGL" = "no" ]; then
  # for OpenGL (GLX) support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL glew"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  # for OpenGL-ES support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
fi
