################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="gpu-viv-bin-mx6q"
PKG_VERSION="3.10.17-1.0.2-hfp"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.freescale.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain gpu-viv-g2d"
PKG_SECTION="graphics"
PKG_SHORTDESC="gpu-viv-bin-mx6q: OpenGL-ES and VIVANTE driver for imx6q"
PKG_LONGDESC="gpu-viv-bin-mx6q: OpenGL-ES and VIVANTE driver for imx6q"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
 : # nothing to make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp -PRv usr/include/* $SYSROOT_PREFIX/usr/include

  LIBS_COPY="usr/lib/libEGL-fb.so \
             usr/lib/libEGL.so* \
             usr/lib/libGLES_CL.so \
             usr/lib/libGLES_CM.so \
             usr/lib/libGLESv1_CL.so* \
             usr/lib/libGLESv1_CM.so* \
             usr/lib/libGLESv2-fb.so \
             usr/lib/libGLESv2.so* \
             usr/lib/libGLSLC.so* \
             usr/lib/libGAL-fb.so \
             usr/lib/libGAL.so* \
             usr/lib/libVIVANTE-fb.so \
             usr/lib/libVIVANTE.so* \
             usr/lib/libOpenCL.so"

  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -PRv $LIBS_COPY $SYSROOT_PREFIX/usr/lib

  mkdir -p $INSTALL/usr/lib
  cp -PRv $LIBS_COPY $INSTALL/usr/lib
}

post_install() {
  enable_service unbind-console.service
}
