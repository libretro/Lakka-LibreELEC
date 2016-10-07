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

PKG_NAME="hdhomerun"
PKG_VERSION="7.0"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.silicondust.com/products/hdhomerun/dvbt/"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="driver/dvb"
PKG_SHORTDESC="HDHomeRun: a Linux driver to add support for HDHomeRun from silicondust.com"
PKG_LONGDESC="Install this to add support for HDHomeRun devices."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="HDHomeRun"
PKG_ADDON_TYPE="xbmc.python.script"
PKG_AUTORECONF="no"

make_target() {
  : # nothing to do here
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/
  cp -P $PKG_DIR/config/* $ADDON_BUILD/$PKG_ADDON_ID/config/
  cp -P $PKG_DIR/settings-default.xml $ADDON_BUILD/$PKG_ADDON_ID/
}
