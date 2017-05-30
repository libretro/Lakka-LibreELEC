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

PKG_NAME="chip-mali-userspace"
PKG_VERSION="a9d2b50"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/NextThingCo/chip-mali-userspace"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="CHIP Mali-400 userspace blob."
PKG_LONGDESC="CHIP Mali-400 userspace blob."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  :
}

make_target() {
  mkdir -p $SYSROOT_PREFIX/etc/udev/rules.d
    cp -PR etc/udev/rules.d/* $SYSROOT_PREFIX/etc/udev/rules.d
  mkdir -p $SYSROOT_PREFIX/usr/include/EGL
  mkdir -p $SYSROOT_PREFIX/usr/include/GLES
  mkdir -p $SYSROOT_PREFIX/usr/include/GLES2
  mkdir -p $SYSROOT_PREFIX/usr/include/KHR
    cp -PR usr/include/* $SYSROOT_PREFIX/usr/include
  mkdir -p $SYSROOT_PREFIX/usr/lib/arm-linux-gnueabihf/pkgconfig
    cp -PR usr/lib/arm-linux-gnueabihf/* $SYSROOT_PREFIX/usr/lib/arm-linux-gnueabihf
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/etc/udev/rules.d
    cp -PR etc/udev/rules.d/* $SYSROOT_PREFIX/etc/udev/rules.d
  mkdir -p $SYSROOT_PREFIX/usr/include/EGL
  mkdir -p $SYSROOT_PREFIX/usr/include/GLES
  mkdir -p $SYSROOT_PREFIX/usr/include/GLES2
  mkdir -p $SYSROOT_PREFIX/usr/include/KHR
    cp -PR usr/include/* $SYSROOT_PREFIX/usr/include
  mkdir -p $SYSROOT_PREFIX/usr/lib/arm-linux-gnueabihf/pkgconfig
    cp -PR usr/lib/arm-linux-gnueabihf/* $SYSROOT_PREFIX/usr/lib/arm-linux-gnueabihf
}
