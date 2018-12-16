# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.mediaportal.tvserver"
PKG_VERSION="25e3e7da9e63d6f769083d68304500b1080a2959"
PKG_SHA256="a100dfae6bcfb7153823edbff5b91582e2a03459bfb2020dd932c5716c999a5c"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/kodi-pvr/pvr.mediaportal.tvserver/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="pvr.mediaportal.tvserver"
PKG_LONGDESC="pvr.mediaportal.tvserver"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

pre_configure_target() {
  CXXFLAGS="$CXXFLAGS -Wno-narrowing -DXLOCALE_NOT_USED"
}
