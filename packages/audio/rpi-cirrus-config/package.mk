################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-2017 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="rpi-cirrus-config"
PKG_VERSION="0.0.1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/HiassofT/rpi-cirrus-config"
PKG_URL="https://github.com/HiassofT/rpi-cirrus-config/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="alsa-utils"
PKG_SECTION="driver"
PKG_SHORTDESC="Config scripts for the Wolfson/Cirrus Logic audio card"
PKG_LONGDESC="Config scripts for the Wolfson/Cirrus Logic audio card"

make_target() {
 : #
}

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
