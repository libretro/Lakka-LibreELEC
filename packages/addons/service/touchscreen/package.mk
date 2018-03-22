################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="touchscreen"
PKG_VERSION="1.0"
PKG_REV="101"
PKG_ARCH="any"
PKG_ADDON_PROJECTS="Generic RPi Amlogic"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain tslib evtest"
PKG_SECTION="service"
PKG_SHORTDESC="Touchscreen: support addon for Touchscreens"
PKG_LONGDESC="Touchscreen: addon creates new virtual input device and \
converts data from touchscreen to Kodi. Short tap sends button press event \
and long tap sends only xy coordinates. Also includes calibration program."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Touchscreen"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin

  cp $PKG_DIR/addon.xml $ADDON_BUILD/$PKG_ADDON_ID

  # set only version (revision will be added by buildsystem)
  $SED -e "s|@ADDON_VERSION@|$ADDON_VERSION|g" \
       -i $ADDON_BUILD/$PKG_ADDON_ID/addon.xml

  cp $(get_build_dir tslib)/.install_pkg/usr/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $(get_build_dir evtest)/.$TARGET_NAME/evtest  $ADDON_BUILD/$PKG_ADDON_ID/bin
}
