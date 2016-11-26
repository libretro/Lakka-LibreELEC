################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="script.config.vdr"
PKG_VERSION="61c2dde"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://libreelec.tv"
PKG_URL="https://github.com/LibreELEC/script.config.vdr/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET=""
PKG_SECTION=""
PKG_SHORTDESC="script.config.vdr"
PKG_LONGDESC="script.config.vdr"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="dummy"

make_target() {
  $SED -e "s|@ADDON_VERSION@|$ADDON_VERSION.$PKG_REV|g" \
       -e "s|@OS_VERSION@|$OS_VERSION|g" \
       -i addon.xml
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -PR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
  cp $PKG_DIR/changelog.txt $ADDON_BUILD/$PKG_ADDON_ID
  cp $PKG_DIR/icon/icon.png $ADDON_BUILD/$PKG_ADDON_ID/resources
}
