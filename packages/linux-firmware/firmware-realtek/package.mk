# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Team Lakka

PKG_NAME="firmware-realtek"
PKG_VERSION="a02fef66bdd7765a1cdd9dd488a7b9b4ecb12d75"
PKG_LICENSE="Free-to-use"
PKG_SITE="https://github.com/Ntemis/firmware-realtek"
PKG_URL="https://github.com/Ntemis/firmware-realtek/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="realtek-firmware: firmwares for various realtek WLAN drivers"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=$INSTALL/$(get_kernel_overlay_dir) ./install
}
