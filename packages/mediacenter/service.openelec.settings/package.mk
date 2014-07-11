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

PKG_NAME="service.openelec.settings"
if [ "$MEDIACENTER" = "xbmc-master" ]; then
  PKG_VERSION="0.4.2"
else
  PKG_VERSION="0.3.19"
fi
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="prop."
PKG_SITE="http://www.openelec.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.zip"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_DEPENDS_TARGET="toolchain Python connman pygobject dbus-python"
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="service.openelec.settings: Settings dialog for OpenELEC"
PKG_LONGDESC="service.openelec.settings: is a settings dialog for OpenELEC"

PKG_IS_ADDON="yes"
PKG_AUTORECONF="no"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET setxkbmap"
else
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bkeymaps"
fi

make_target() {
 : # nothing todo
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/xbmc/addons/service.openelec.settings
    cp -R * $INSTALL/usr/share/xbmc/addons/service.openelec.settings

  mkdir -p $INSTALL/usr/lib/openelec
    cp $PKG_DIR/scripts/* $INSTALL/usr/lib/openelec

  # bluetooth is optional
    if [ ! "$BLUETOOTH_SUPPORT" = yes ]; then
      rm -f resources/lib/modules/bluetooth.py
    fi

  python -Wi -t -B $ROOT/$TOOLCHAIN/lib/python2.7/compileall.py $INSTALL/usr/share/xbmc/addons/service.openelec.settings/resources/lib/ -f
  rm -rf `find $INSTALL/usr/share/xbmc/addons/service.openelec.settings/resources/lib/ -name "*.py"`

  python -Wi -t -B $ROOT/$TOOLCHAIN/lib/python2.7/compileall.py $INSTALL/usr/share/xbmc/addons/service.openelec.settings/oe.py -f
  rm -rf $INSTALL/usr/share/xbmc/addons/service.openelec.settings/oe.py
}

post_install() {
  enable_service backup-restore.service
  enable_service factory-reset.service
}
