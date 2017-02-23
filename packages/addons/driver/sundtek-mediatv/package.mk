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

PKG_NAME="sundtek-mediatv"
PKG_VERSION="7.0"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://support.sundtek.com/"
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_SECTION="driver/dvb"
PKG_SHORTDESC="Sundtek MediaTV: a Linux driver to add support for SUNDTEK USB DVB devices"
PKG_LONGDESC="Install this to add support for Sundtek USB DVB devices."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Sundtek MediaTV"
PKG_ADDON_TYPE="xbmc.service"
PKG_AUTORECONF="no"

make_target() {
  mkdir -p $PKG_BUILD
  cd $PKG_BUILD

  case $TARGET_ARCH in
    x86_64)
      INSTALLER_URL="http://sundtek.de/media/netinst/64bit/installer.tar.gz"
      ;;
    arm)
      INSTALLER_URL="http://sundtek.de/media/netinst/armsysvhf/installer.tar.gz"
      ;;
    aarch64)
      INSTALLER_URL="http://sundtek.de/media/netinst/arm64/installer.tar.gz"
      ;;
  esac
  
  wget -O installer.tar.gz $INSTALLER_URL
  
  tar -xzf installer.tar.gz
  
  chmod -R 755 opt/ etc/
  
  rm -f  opt/bin/getinput.sh
  rm -f  opt/bin/lirc.sh
  rm -fr opt/lib/pm/

  wget -O version.used http://sundtek.de/media/latest.phtml
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config/
  cp -P $PKG_DIR/config/* $ADDON_BUILD/$PKG_ADDON_ID/config/
  cp -P $PKG_DIR/settings-default.xml $ADDON_BUILD/$PKG_ADDON_ID/
  cp -Pa $PKG_BUILD/opt/bin $ADDON_BUILD/$PKG_ADDON_ID/
  cp -Pa $PKG_BUILD/opt/lib $ADDON_BUILD/$PKG_ADDON_ID/
  cp $PKG_BUILD/version.used $ADDON_BUILD/$PKG_ADDON_ID/
}
