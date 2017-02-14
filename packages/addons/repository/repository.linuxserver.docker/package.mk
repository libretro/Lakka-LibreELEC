################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
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

PKG_NAME="repository.linuxserver.docker"
PKG_VERSION="8.1"
PKG_REV="101"
PKG_ARCH="any"
PKG_ADDON_PROJECTS="Generic RPi RPi2 imx6 WeTek_Hub WeTek_Play_2 Odroid_C2"
PKG_LICENSE="GPL"
PKG_SITE="https://linuxserver.io"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain xmlstarlet:host"
PKG_SECTION=""
PKG_SHORTDESC="LinuxServer.io docker add-on repository"
PKG_LONGDESC="LinuxServer.io docker add-on repository"
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="LinuxServer.io Repository"
PKG_ADDON_TYPE="xbmc.addon.repository"


make_target() {
  $SED -e "s|@PKG_VERSION@|$PKG_VERSION|g" \
       -e "s|@PKG_REV@|$PKG_REV|g" \
       -i addon.xml
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -R $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
}
