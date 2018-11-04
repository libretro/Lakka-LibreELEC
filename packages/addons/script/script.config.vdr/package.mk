# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="script.config.vdr"
PKG_VERSION="61c2dde"
PKG_SHA256="40e204ceae6e1e0c30810b891e0fb240ceec2988bab9c41d265f94db6b3c121f"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://libreelec.tv"
PKG_URL="https://github.com/LibreELEC/script.config.vdr/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET=""
PKG_SECTION=""
PKG_SHORTDESC="script.config.vdr"
PKG_LONGDESC="script.config.vdr"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="dummy"

make_target() {
  sed -e "s|@ADDON_VERSION@|$ADDON_VERSION.$PKG_REV|g" \
      -e "s|@OS_VERSION@|$OS_VERSION|g" \
      -i addon.xml
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -PR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
  cp $PKG_DIR/changelog.txt $ADDON_BUILD/$PKG_ADDON_ID
  cp $PKG_DIR/icon/icon.png $ADDON_BUILD/$PKG_ADDON_ID/resources
}
