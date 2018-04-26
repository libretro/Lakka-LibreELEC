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

PKG_NAME="odroidxu3-mali"
PKG_VERSION="r12p004rel0linux1wayland"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://malideveloper.arm.com/resources/drivers/arm-mali-midgard-gpu-user-space-drivers/"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-drivers/user-space/odroid-xu3/malit62xr12p004rel0linux1wayland.tar.gz"
PKG_SOURCE_DIR="wayland"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_TARGET="libdrm mesa wayland Mali_OpenGL_ES_SDK"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="Mali-t62x blobs for Odroid-XU3/XU4"
PKG_LONGDESC="Mali-t62x blobs for Odroid-XU3/XU4"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
LIBMALI_ARCH="arm-linux-gnueabihf"
LIBMALI_FILE="libmali.so"

make_target() {
 : # nothing todo
}

makeinstall_target() {

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PRv $LIBMALI_FILE $SYSROOT_PREFIX/usr/lib
    ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libwayland-egl.so
    ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so
    ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libEGL.so
    ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so
    ln -sf libmali.so $SYSROOT_PREFIX/usr/lib/libgbm.so

  mkdir -p $INSTALL/usr/lib
    cp -PRv $LIBMALI_FILE $INSTALL/usr/lib
    ln -sf libmali.so $INSTALL/usr/lib/libwayland-egl.so
    ln -sf libmali.so $INSTALL/usr/lib/libGLESv1_CM.so
    ln -sf libmali.so $INSTALL/usr/lib/libEGL.so
    ln -sf libmali.so $INSTALL/usr/lib/libGLESv2.so
    ln -sf libmali.so $INSTALL/usr/lib/libgbm.so
}

