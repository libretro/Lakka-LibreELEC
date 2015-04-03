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

PKG_NAME="irserver"
PKG_VERSION="6.03.08"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Freeware"
PKG_SITE="http://http://www.irtrans.de"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="sysutils/remote"
PKG_SHORTDESC="irserver: IR Trans transforms your PC into a programmable remote control."
PKG_LONGDESC="IR Trans transforms your PC into a programmable remote control: It learns the codes of your remote control, stores them in a database and sends them controlled by your applications."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_ARCH" = "x86_64" ]; then
  IRSERVER_BIN="irserver64"
elif [ "$TARGET_ARCH" = "arm" ]; then
  IRSERVER_BIN="irserver_arm"
fi

make_target() {
  make CC=$TARGET_CC CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" $IRSERVER_BIN
  $STRIP $IRSERVER_BIN
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/config
    cp $PKG_DIR/config/*.conf $INSTALL/usr/config

  mkdir -p $INSTALL/usr/sbin
    cp -P $IRSERVER_BIN $INSTALL/usr/sbin/irserver

  mkdir -p $INSTALL/usr/share/irtrans/remotes
    cp remotes/irtrans.rem $INSTALL/usr/share/irtrans/remotes
    cp remotes/mediacenter.rem $INSTALL/usr/share/irtrans/remotes
}
