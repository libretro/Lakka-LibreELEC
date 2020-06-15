# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.argustv"
PKG_VERSION="3.5.6-Leia"
PKG_SHA256="7bfedb27b2aec4015b2594df18b76fe42e97ec10f4b5cb9c6987b1a7a264c844"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.argustv"
PKG_URL="https://github.com/kodi-pvr/pvr.argustv/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform jsoncpp"
PKG_SECTION=""
PKG_SHORTDESC="pvr.argustv"
PKG_LONGDESC="pvr.argustv"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

pre_configure_target() {
  CXXFLAGS="$CXXFLAGS -Wno-narrowing"
}
