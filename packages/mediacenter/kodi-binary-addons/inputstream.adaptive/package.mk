# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inputstream.adaptive"
PKG_VERSION="2.6.11-Matrix"
PKG_SHA256="1d0cc5ba1a7e7375813948d057566c987e9b1601ae0a46247cd8ce90d5fd7c86"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/inputstream.adaptive"
PKG_URL="https://github.com/xbmc/inputstream.adaptive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="inputstream.adaptive"
PKG_LONGDESC="inputstream.adaptive"

PKG_IS_ADDON="yes"

if [ "${TARGET_ARCH}" = "x86_64" ] || [ "${TARGET_ARCH}" = "arm" ]; then
  PKG_DEPENDS_TARGET+=" nss"
fi

addon() {
  install_binary_addon ${PKG_ADDON_ID}

  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}
  cp -P ${PKG_BUILD}/.${TARGET_NAME}/wvdecrypter/libssd_wv.so ${ADDON_BUILD}/${PKG_ADDON_ID}
}
