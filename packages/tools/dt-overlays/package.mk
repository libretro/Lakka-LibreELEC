# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dt-overlays"
PKG_VERSION="e57a9b1eadd420a4e5d50c0669184828ff12abc5"
PKG_SHA256="b63ee4f54723349ce405c9bd3545b5bb0814e4d1959a6a1db0bb2517318b1cc5"
PKG_LICENSE="GPLv2+ or MIT"
PKG_SITE="https://github.com/LibreELEC/dt-overlays"
PKG_URL="https://github.com/LibreELEC/dt-overlays/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="dtc:host"
PKG_LONGDESC="The Device Tree Overlays"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader/overlays
    cp -p overlays/*/*.dtbo $INSTALL/usr/share/bootloader/overlays
}
