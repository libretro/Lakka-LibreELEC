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

PKG_NAME="eventlircd"
PKG_VERSION="3b753e9"
PKG_SHA256="4eca52d0570fa568b3296a2c9bc2af252423e25c1a67654bd79680fc5a93092a"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/eventlircd"
PKG_URL="https://github.com/LibreELEC/eventlircd/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain systemd lirc"
PKG_SECTION="system/remote"
PKG_SHORTDESC="eventlircd:The eventlircd daemon provides various functions for LIRC devices"
PKG_LONGDESC="The eventlircd daemon provides four functions for LIRC devices"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-udev-dir=/usr/lib/udev"

post_makeinstall_target() {
# install our own evmap files and udev rules
  rm -rf $INSTALL/etc/eventlircd.d
  rm -rf $INSTALL/usr/lib/udev/rules.d
  rm -rf $INSTALL/usr/lib/udev/lircd_helper

  mkdir -p $INSTALL/etc/eventlircd.d
    cp $PKG_DIR/evmap/*.evmap $INSTALL/etc/eventlircd.d
}

post_install() {
  enable_service eventlircd.service
}
