# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.goom"
PKG_VERSION="7c91a206769534adc8a583feaed81cdb8659f64f"
PKG_SHA256="6197847d922050b37ce8a2a20436c16d10a48566f7128570965aa082fe203fc4"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/visualization.goom"
PKG_URL="https://github.com/notspiff/visualization.goom/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="visualization.goom"
PKG_LONGDESC="visualization.goom"
PKG_TOOLCHAIN="cmake-make"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
