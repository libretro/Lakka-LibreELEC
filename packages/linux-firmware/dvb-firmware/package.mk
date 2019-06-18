# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvb-firmware"
PKG_VERSION="1.4.0"
PKG_SHA256="17d6a5727f7728ef618055089eb78372b3af7ed64ff3ed116211258727188ff0"
PKG_LICENSE="Free-to-use"
PKG_SITE="https://github.com/LibreELEC/dvb-firmware"
PKG_URL="https://github.com/LibreELEC/dvb-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dvb-firmware: firmwares for various DVB drivers"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  PKG_FW_DIR="$INSTALL/$(get_kernel_overlay_dir)/lib/firmware"
  mkdir -p "$PKG_FW_DIR"
    cp -a "$PKG_BUILD/firmware/"* "$PKG_FW_DIR"
}
