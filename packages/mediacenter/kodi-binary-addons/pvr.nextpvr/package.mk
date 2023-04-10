# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.nextpvr"
PKG_VERSION="21.0.0-Omega"
PKG_SHA256="b56ec53c93d270559754b836514565fff35eca6a93f677e16108ffade96d514b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.nextpvr"
PKG_URL="https://github.com/kodi-pvr/pvr.nextpvr/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform tinyxml2"
PKG_SECTION=""
PKG_SHORTDESC="pvr.nextpvr"
PKG_LONGDESC="pvr.nextpvr"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

pre_configure_target() {
  CXXFLAGS+=" -Wno-narrowing"
}
