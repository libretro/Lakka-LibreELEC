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

PKG_NAME="xbmc-pvr-addons"
PKG_VERSION="9d33717"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/opdenkamp/xbmc-pvr-addons"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain curl"
PKG_PRIORITY="optional"
PKG_SECTION="mediacenter"
PKG_SHORTDESC="Various PVR addons for XBMC" 
PKG_LONGDESC="This addons allows XBMC PVR to connect to various TV/PVR backends and tuners."
PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$MYSQL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mysql"
  PVRADDONS_MYSQL="--enable-mysql"
else
  PVRADDONS_MYSQL="--disable-mysql"
fi

PKG_CONFIGURE_OPTS_TARGET="--enable-addons-with-dependencies $PVRADDONS_MYSQL"

post_makeinstall_target() {
  if [ "$DEBUG" != yes ]; then
    $STRIP $INSTALL/usr/lib/xbmc/addons/pvr.*/*.pvr
  fi
}
