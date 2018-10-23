# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inputstream.adaptive"
PKG_VERSION="e42f85ff95f55e343d5fcca0d9ff73d7afeca49d"
PKG_SHA256="3b1f0fb04c4b3110c8640d4fa9b50dca3ccfd2a810b40fe4a62b331fc2bdabc9"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/peak3d/inputstream.adaptive/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="inputstream.adaptive"
PKG_LONGDESC="inputstream.adaptive"

PKG_IS_ADDON="yes"

if [ "$TARGET_ARCH" = "x86_64" ] || [ "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET nss"
fi

addon() {
  install_binary_addon $PKG_ADDON_ID

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -P $PKG_BUILD/.$TARGET_NAME/wvdecrypter/libssd_wv.so $ADDON_BUILD/$PKG_ADDON_ID
}
