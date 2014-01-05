################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="sundtek-mediatv"
PKG_VERSION="4.1"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://support.sundtek.com/"
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_BUILD_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION="driver/dvb"
PKG_SHORTDESC="Sundtek USB Stick DVB userspace driver"
PKG_LONGDESC="Driver for Sundtek MediaTV Pro (DVB-C, DVB-T, AnalogTV, Composite, S-Video, FM-Radio USB Stick) and Sundtek SkyTV Ultimate (DVB-S/S2 USB)."
PKG_IS_ADDON="yes"
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
