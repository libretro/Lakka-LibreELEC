# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.mediaportal.tvserver"
PKG_VERSION="21.0.2-Omega"
PKG_SHA256="9e8c92b49433f46ae681055762ca4c152481b258c9163a1119c1ca08d7e9fd7c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.mediaportal.tvserver"
PKG_URL="https://github.com/kodi-pvr/pvr.mediaportal.tvserver/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="pvr.mediaportal.tvserver"
PKG_LONGDESC="pvr.mediaportal.tvserver"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

pre_configure_target() {
  CXXFLAGS+=" -Wno-narrowing -DXLOCALE_NOT_USED"
}
