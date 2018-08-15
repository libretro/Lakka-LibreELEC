# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.projectm"
PKG_VERSION="5da5a45a5fc6ed22244cb075e029e28b1ff8d69b"
PKG_SHA256="7e0063c5cbaa9f1250bf10fda04abfe0b0f01b751ca951b62c1388354279b424"
PKG_REV="2"
PKG_ARCH="any"
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
