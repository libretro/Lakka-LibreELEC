# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slice-addon"
PKG_VERSION="1.0"
PKG_REV="101"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_LONGDESC="Controls the LED lights on the Slice box using Kodi actions"
PKG_TOOLCHAIN="manual"

make_target() {
(
  cd $ROOT
  scripts/create_addon slice
)
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/kodi/addons
    cp -R $BUILD/$ADDONS/slice/service.slice $INSTALL/usr/share/kodi/addons
}
