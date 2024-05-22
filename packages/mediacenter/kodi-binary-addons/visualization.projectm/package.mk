# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.projectm"
PKG_VERSION="21.0.1-Omega"
PKG_SHA256="71e99eb4ba79df21afa17a058b77905f56daa2417a94b1b7cf557efa2b48a64a"
PKG_REV="1"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/visualization.projectm"
PKG_URL="https://github.com/xbmc/visualization.projectm/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libprojectM"
PKG_SECTION=""
PKG_SHORTDESC="visualization.projectm"
PKG_LONGDESC="visualization.projectm"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

pre_configure_target() {
  export LDFLAGS=$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||")
}
