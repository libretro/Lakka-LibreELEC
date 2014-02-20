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

PKG_NAME="eventlircd"
PKG_VERSION="42"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://code.google.com/p/eventlircd"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain systemd lirc"
PKG_PRIORITY="optional"
PKG_SECTION="system/remote"
PKG_SHORTDESC="eventlircd:The eventlircd daemon provides various functions for LIRC devices"
PKG_LONGDESC="The eventlircd daemon provides four functions for LIRC devices"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--with-udev-dir=/usr/lib/udev"

post_makeinstall_target() {
# install our own evmap files and udev rules
  rm -rf $INSTALL/etc/eventlircd.d
  rm -rf $INSTALL/usr/lib/udev/rules.d

  mkdir -p $INSTALL/etc/eventlircd.d
    cp $PKG_DIR/evmap/*.evmap $INSTALL/etc/eventlircd.d
}

post_install() {
  enable_service eventlircd.service
}
