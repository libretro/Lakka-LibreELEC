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

PKG_NAME="opengl-mali"
PKG_VERSION="20130520"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.arm.com/products/multimedia/mali-graphics-hardware/mali-400-mp.php"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="opengl-mali: OpenGL-ES and Mali driver for Mali 400 GPUs"
PKG_LONGDESC="opengl-mali: OpenGL-ES and Mali driver for Mali 400 GPUs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
 : # nothing todo
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR src/include/* $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR src/lib/*.so* $SYSROOT_PREFIX/usr/lib
    ln -sf libEGL.so.1.4 $SYSROOT_PREFIX/usr/lib/libEGL.so
    ln -sf libGLESv1_CM.so.1.1 $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so
    ln -sf libGLESv2.so.2.0 $SYSROOT_PREFIX/usr/lib/libGLESv2.so

  mkdir -p $INSTALL/usr/lib
    cp -PR src/lib/*.so* $INSTALL/usr/lib
    ln -sf libEGL.so.1.4 $INSTALL/usr/lib/libEGL.so
    ln -sf libGLESv1_CM.so.1.1 $INSTALL/usr/lib/libGLESv1_CM.so
    ln -sf libGLESv2.so.2.0 $INSTALL/usr/lib/libGLESv2.so
}

