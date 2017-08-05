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

PKG_NAME="slice-addon"
PKG_VERSION="1.0"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_SHORTDESC="Controls the LED lights on the Slice box using Kodi actions"
PKG_LONGDESC="Controls the LED lights on the Slice box using Kodi actions"
PKG_AUTORECONF="no"

PKG_IS_ADDON="no"

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
