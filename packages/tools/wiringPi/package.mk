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

PKG_NAME="wiringPi"
PKG_VERSION="b1dfc18"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPLv3"
PKG_SITE="http://wiringpi.com/"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="GPIO Interface library for the Raspberry Pi"
PKG_LONGDESC="GPIO Interface library for the Raspberry Pi"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/
  mkdir -p $SYSROOT_PREFIX/usr/include/
  mkdir -p $INSTALL/usr/lib/

  cp wiringPi/*.h $SYSROOT_PREFIX/usr/include/
  make -C wiringPi CFLAGS="$CFLAGS" LDFLAGS="$LDFLAGS" V=1 static
}

makeinstall_target() {
  cp -v wiringPi/libwiringPi.a* $INSTALL/usr/lib/
  cp -v wiringPi/libwiringPi.a* $SYSROOT_PREFIX/usr/lib/
}
