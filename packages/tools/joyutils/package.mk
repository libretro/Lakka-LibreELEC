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

PKG_NAME="joyutils"
PKG_VERSION="1.2.15"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://atrey.karlin.mff.cuni.cz/~vojtech/joystick/"
PKG_URL="ftp://atrey.karlin.mff.cuni.cz/pub/linux/joystick/joystick-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="jscal, jstest, and jsattach utilities for the Linux joystick driver"
PKG_LONGDESC="jscal, jstest, and jsattach utilities for the Linux joystick driver"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  mv $BUILD/joystick-$PKG_VERSION $BUILD/$PKG_NAME-$PKG_VERSION
}

make_target() {
  $CC -lm -o jscal jscal.c $CFLAGS
  $CC -lm -o jstest jstest.c $CFLAGS
  $CC -lm -o jsattach jsattach.c $CFLAGS
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp jscal $INSTALL/usr/bin/
  cp jstest $INSTALL/usr/bin/
  cp jsattach $INSTALL/usr/bin/
}
