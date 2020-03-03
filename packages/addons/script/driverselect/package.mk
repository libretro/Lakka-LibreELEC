# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="driverselect"
PKG_VERSION="ee784f2d79bc5b3125dd77733b55f0227f2f5914"
PKG_SHA256="9ae121a31f1a204fac9888bca327a8e876be3dfaf2924ccf88a6c0192bb1fa9c"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://libreelec.tv"
PKG_URL="https://github.com/b-jesch/script.program.driverselect/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="script.program"
PKG_SHORTDESC="script.program.driverselect"
PKG_LONGDESC="script.program.driverselect"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="embedded"
PKG_ADDON_NAME="Driver Select"
PKG_ADDON_TYPE="xbmc.python.script"

unpack() {
  mkdir -p ${PKG_BUILD}/addon
  tar --strip-components=1 -xf ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD}/addon
}

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/kodi/addons/${PKG_SECTION}.${PKG_NAME}
  cp -rP ${PKG_BUILD}/addon/* ${INSTALL}/usr/share/kodi/addons/${PKG_SECTION}.${PKG_NAME}
}
