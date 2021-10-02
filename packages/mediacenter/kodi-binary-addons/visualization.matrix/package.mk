# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.matrix"
PKG_VERSION="20.0.0-Nexus"
PKG_SHA256="dcede7e6abad2eb3bc7c2309bd3a0aa8833b437d0792ac1ea8c4fa1da628fa29"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/visualization.matrix"
PKG_URL="https://github.com/xbmc/visualization.matrix/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform glm"
PKG_SECTION=""
PKG_LONGDESC="visualization.matrix"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ ! "${OPENGL}" = "no" ]; then
  # for OpenGL (GLX) support
  PKG_DEPENDS_TARGET+=" ${OPENGL} glew"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  # for OpenGL-ES support
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi
