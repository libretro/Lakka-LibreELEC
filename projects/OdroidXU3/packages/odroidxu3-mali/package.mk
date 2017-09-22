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
PKG_VERSION="r12p004rel0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://malideveloper.arm.com/resources/drivers/arm-mali-midgard-gpu-user-space-drivers/"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-drivers/user-space/odroid-xu3/malit62xr12p004rel0linux1fbdev.tar.gz"
PKG_SOURCE_DIR="fbdev"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_TARGET="libump odroidxu3-mali-headers"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="Mali-t62x blobs for Odroid-XU3/XU4"
PKG_LONGDESC="Mali-t62x blobs for Odroid-XU3/XU4"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

#unpack() {
#  $SCRIPTS/extract $PKG_NAME $(basename $PKG_URL) $BUILD
#}

make_target() {
  ln -sfn libmali.so libEGL.so
  ln -sfn libmali.so libGLESv2.so

  rm -f libGLESv1_CM.so
  rm -f libOpenCL.so

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR * $SYSROOT_PREFIX/usr/lib
}

makeinstall_target() {
  ln -sfn libmali.so libEGL.so
  ln -sfn libmali.so libGLESv2.so

  rm -f libGLESv1_CM.so
  rm -f libOpenCL.so

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR * $SYSROOT_PREFIX/usr/lib
  mkdir -p $INSTALL/usr/lib
    cp -PR * $INSTALL/usr/lib
}

