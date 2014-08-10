################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="repository.unofficial.addon.pro"
PKG_VERSION="4.3.1"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://unofficial.addon.pro"
PKG_URL=""
PKG_DEPENDS_TARGET=""
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="Unfficial OpenELEC.tv Add-on Repository"
PKG_LONGDESC="Unfficial OpenELEC.tv Add-on Repository"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.addon.repository"

PKG_AUTORECONF="no"

PKG_MAINTAINER="unofficial.addon.pro"

make_target() {
  $SED -e "s|@ADDON_VERSION@|$ADDON_VERSION|g" \
     -e "s|@PROJECT@|$PROJECT|g" \
     -e "s|@ARCH@|$ARCH|g" \
     -e "s|@PKG_VERSION@|$PKG_VERSION|g" \
  -i addon.xml
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -R $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
}
