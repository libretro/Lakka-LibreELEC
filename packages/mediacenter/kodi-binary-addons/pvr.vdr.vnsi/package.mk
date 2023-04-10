# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pvr.vdr.vnsi"
PKG_VERSION="21.0.1-Omega"
PKG_SHA256="ff74ad9023a4f10ad4be77b37f94786478ccbaa0ad719618448d750074797165"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kodi-pvr/pvr.vdr.vnsi"
PKG_URL="https://github.com/kodi-pvr/pvr.vdr.vnsi/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="pvr.vdr.vnsi"
PKG_LONGDESC="pvr.vdr.vnsi"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.pvrclient"

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi
