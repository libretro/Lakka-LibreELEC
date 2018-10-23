# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="gpu-viv-bin-mx6q"
PKG_VERSION="3.10.17-1.0.2-hfp"
PKG_SHA256="fcf5cc1c2507d77b6ecaef6defd63fbd604be5a765f86922530cb423a595a592"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.freescale.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain gpu-viv-g2d"
PKG_LONGDESC="gpu-viv-bin-mx6q: OpenGL-ES and VIVANTE driver for imx6q"

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
