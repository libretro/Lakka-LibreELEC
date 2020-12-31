# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wireless-regdb"
PKG_VERSION="2020.11.20"
PKG_SHA256="b4164490d82ff7b0086e812ac42ab27baf57be24324d4c0ee1c5dd6ba27f2a52"
PKG_LICENSE="GPL"
PKG_SITE="http://wireless.kernel.org/en/developers/Regulatory"
PKG_URL="https://www.kernel.org/pub/software/network/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_LONGDESC="wireless-regdb is a regulatory database"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  FW_TARGET_DIR=$INSTALL/$(get_full_firmware_dir)

  mkdir -p ${FW_TARGET_DIR}
    cp ${PKG_BUILD}/regulatory.db ${PKG_BUILD}/regulatory.db.p7s ${FW_TARGET_DIR}
}
