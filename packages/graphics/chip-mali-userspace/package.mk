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

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/etc/udev/rules.d
    #cp -PR etc/udev/rules.d/* $SYSROOT_PREFIX/etc/udev/rules.d
    cp -PR usr/include/* $SYSROOT_PREFIX/usr/include
    cp -PR usr/lib/arm-linux-gnueabihf/* $SYSROOT_PREFIX/usr/lib

    ln -sf $SYSROOT_PREFIX/usr/lib/libMali.so $SYSROOT_PREFIX/usr/lib/libEGL.so
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/usr/lib/libEGL.so.1
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/libEGL.so.1.4
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/libGLESv2.so
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/libGLESv2.so.2
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/libGLESv2.so.2.0
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/libGLESv1_CM.so
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/libGLESv1_CM.so.1
    ln -sf $SYSROOT_PREFIX/libMali.so $SYSROOT_PREFIX/libGLESv1_CM.so.1.1

  mkdir -p $INSTALL/etc/udev/rules.d
  mkdir -p $INSTALL/usr/include
  mkdir -p $INSTALL/usr/lib
    #cp -PR etc/udev/rules.d/* $INSTALL/etc/udev/rules.d
    cp -PR usr/include/* $INSTALL/usr/include
    cp -PR usr/lib/arm-linux-gnueabihf/* $INSTALL/usr/lib

    ln -sf $INSTALL/usr/lib/libMali.so $INSTALL/usr/lib/libEGL.so
    ln -sf $INSTALL/libMali.so $INSTALL/usr/lib/libEGL.so.1
    ln -sf $INSTALL/libMali.so $INSTALL/libEGL.so.1.4
    ln -sf $INSTALL/libMali.so $INSTALL/libGLESv2.so
    ln -sf $INSTALL/libMali.so $INSTALL/libGLESv2.so.2
    ln -sf $INSTALL/libMali.so $INSTALL/libGLESv2.so.2.0
    ln -sf $INSTALL/libMali.so $INSTALL/libGLESv1_CM.so
    ln -sf $INSTALL/libMali.so $INSTALL/libGLESv1_CM.so.1
    ln -sf $INSTALL/libMali.so $INSTALL/libGLESv1_CM.so.1.1
}
