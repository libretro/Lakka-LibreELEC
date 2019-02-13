# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slice"
PKG_VERSION="0"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="service"
PKG_SHORTDESC="Provides the ability to change the led lights on the Slice box via Kodi actions"
PKG_LONGDESC="Provides the ability to change the led lights on the Slice box via Kodi actions"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="embedded"
PKG_ADDON_NAME="Slice"
PKG_ADDON_PROJECTS="Slice Slice3"
PKG_ADDON_TYPE="xbmc.service"

makeinstall_target() {
  PKG_ADDON_INSTALL_DIR="${INSTALL}/usr/share/kodi/addons/${PKG_SECTION}.${PKG_NAME}"
  mkdir -p "${PKG_ADDON_INSTALL_DIR}"
    install_addon_files "${PKG_ADDON_INSTALL_DIR}"
}

addon() {
  :
}
