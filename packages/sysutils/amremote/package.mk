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

PKG_NAME="amremote"
PKG_VERSION="6431040"
PKG_SHA256="5859680b0951ed3d2265999b7ad5309060587815df4dd1c48c6fa9aae039d5c5"
PKG_ARCH="arm aarch64"
PKG_LICENSE="other"
PKG_SITE="http://www.amlogic.com"
PKG_URL="https://github.com/codesnake/amremote/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain usbutils"
PKG_SECTION="sysutils/remote"
PKG_SHORTDESC="amremote - IR remote configuration utility for Amlogic-based devices"
PKG_LONGDESC="amremote - IR remote configuration utility for Amlogic-based devices"
PKG_AUTORECONF="no"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp remotecfg $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/* $INSTALL/usr/lib/libreelec

  mkdir -p $INSTALL/etc/amremote
    cp $PKG_DIR/config/*.conf $INSTALL/etc/amremote
}

post_install() {
  enable_service amlogic-remotecfg.service
}
