################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="imagedecoder.raw"
PKG_VERSION="1ab2416"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/imagedecoder.raw"
PKG_URL="https://github.com/notspiff/imagedecoder.raw/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libraw"
PKG_SECTION=""
PKG_SHORTDESC="imagedecoder.raw"
PKG_LONGDESC="imagedecoder.raw"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.imagedecoder"

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/
  cp -R $PKG_BUILD/.install_pkg/usr/share/$MEDIACENTER/addons/$PKG_NAME/* $ADDON_BUILD/$PKG_ADDON_ID/

  ADDONSO=$(xmlstarlet sel -t -v "/addon/extension/@library_linux" $ADDON_BUILD/$PKG_ADDON_ID/addon.xml)
  cp -L $PKG_BUILD/.install_pkg/usr/lib/$MEDIACENTER/addons/$PKG_NAME/$ADDONSO $ADDON_BUILD/$PKG_ADDON_ID/
}
