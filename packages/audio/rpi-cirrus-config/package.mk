# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rpi-cirrus-config"
PKG_VERSION="0.0.1"
PKG_SHA256="a2a580d9738aaf4e901d8215cedd1df5d95b1e057165cfd9b72335e0dc6c40e4"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/HiassofT/rpi-cirrus-config"
PKG_URL="https://github.com/HiassofT/rpi-cirrus-config/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="alsa-utils"
PKG_LONGDESC="Config scripts for the Wolfson/Cirrus Logic audio card"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/udev
  install -m 0755 $PKG_DIR/scripts/rpi-cirrus-config $INSTALL/usr/lib/udev/rpi-cirrus-config

  mkdir -p $INSTALL/usr/share/alsa/cards
  cp alsa/RPiCirrus.conf $INSTALL/usr/share/alsa/cards

  mkdir -p $INSTALL/usr/lib/alsa
  cp mixer-scripts/rpi-cirrus-functions.sh $INSTALL/usr/lib/alsa

  mkdir -p $INSTALL/usr/config
  cp -PR $PKG_DIR/config/* $INSTALL/usr/config
}
