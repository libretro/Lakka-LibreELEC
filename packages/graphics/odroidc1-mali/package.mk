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

PKG_NAME="odroidc1-mali"
PKG_VERSION="cdf9ddb"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/mdrjr/c1_mali_libs"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_TARGET="libump"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="Mali-450 blobs for Odroid-C1"
PKG_LONGDESC="Mali-450 blobs for Odroid-C1"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  :
}

make_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR fbdev/mali_libs/* $SYSROOT_PREFIX/usr/lib
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR fbdev/mali_headers/* $SYSROOT_PREFIX/usr/include
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR fbdev/mali_libs/* $SYSROOT_PREFIX/usr/lib
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR fbdev/mali_headers/* $SYSROOT_PREFIX/usr/include
  mkdir -p $INSTALL/usr/lib
    cp -PR fbdev/mali_libs/*.so* $INSTALL/usr/lib
}

