# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvb-firmware"
PKG_VERSION="1.3.0"
PKG_SHA256="0a0e64a759b4597d2c31209db0cc6458b658799e93dcdd0ddb58220fc6cbf393"
PKG_ARCH="any"
PKG_LICENSE="Free-to-use"
PKG_SITE="https://github.com/LibreELEC/dvb-firmware"
PKG_URL="https://github.com/LibreELEC/dvb-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_LONGDESC="dvb-firmware: firmwares for various DVB drivers"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  PKG_FW_DIR="$INSTALL/$(get_kernel_overlay_dir)/lib/firmware"
  mkdir -p "$PKG_FW_DIR"
    cp -a "$PKG_BUILD/firmware/"* "$PKG_FW_DIR"
}
