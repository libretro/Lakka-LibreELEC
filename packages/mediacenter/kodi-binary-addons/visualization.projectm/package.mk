# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.projectm"
PKG_VERSION="b5be54b5a65e6ca66e37a66b647cb8621797104a"
PKG_SHA256="4322fe167106af12300b81ce0978bc49eb21fbd24c145f12c76cc02f66521a13"
PKG_REV="2"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/visualization.projectm"
PKG_URL="https://github.com/notspiff/visualization.projectm/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libprojectM"
PKG_SECTION=""
PKG_SHORTDESC="visualization.projectm"
PKG_LONGDESC="visualization.projectm"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi

pre_configure_target() {
  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`
}
