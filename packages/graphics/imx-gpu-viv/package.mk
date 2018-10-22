# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="imx-gpu-viv"
if [ "$LINUX" = "imx6-3.14-sr" ]; then
  PKG_VERSION="5.0.11.p4.5-hfp"
  PKG_SHA256="2dfcacd17f8009b1a235a2df2b398f22afccb6f671953e442c04cd74234312f0"
elif [ "$LINUX" = "imx6-4.4-xbian" ]; then
  PKG_VERSION="5.0.11.p7.4-hfp"
  PKG_SHA256="252b2a8badbc74ca91916490782225affba3908813374baaa7d6267f1de9dae6"
else
  exit 0
fi
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.freescale.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="imx-gpu-viv: OpenGL-ES and VIVANTE driver for imx6q"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp -PRv gpu-core/usr/include/* $SYSROOT_PREFIX/usr/include
  cp -PRv g2d/usr/include/* $SYSROOT_PREFIX/usr/include

  LIBS_COPY="gpu-core/usr/lib/libEGL-fb.so \
             gpu-core/usr/lib/libEGL.so* \
             gpu-core/usr/lib/libGLES_CL.so* \
             gpu-core/usr/lib/libGLES_CM.so* \
             gpu-core/usr/lib/libGLESv1_CL.so* \
             gpu-core/usr/lib/libGLESv1_CM.so* \
             gpu-core/usr/lib/libGLESv2-fb.so \
             gpu-core/usr/lib/libGLESv2.so* \
             gpu-core/usr/lib/libGLSLC.so* \
             gpu-core/usr/lib/libGAL-fb.so \
             gpu-core/usr/lib/libGAL.so* \
             gpu-core/usr/lib/libVIVANTE-fb.so \
             gpu-core/usr/lib/libVIVANTE.so* \
             gpu-core/usr/lib/libOpenCL.so \
             gpu-core/usr/lib/libVSC.so \
             g2d/usr/lib/libg2d*.so*"

  # missing in 5.0.11.p7.4-hfp
  if [ "$PKG_VERSION" = "5.0.11.p4.5-hfp" ]; then
    LIBS_COPY="$LIBS_COPY \
               gpu-core/usr/lib/libGAL_egl.fb.so \
               gpu-core/usr/lib/libGAL_egl.so*"
  fi

  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -PRv $LIBS_COPY $SYSROOT_PREFIX/usr/lib

  mkdir -p $INSTALL/usr/lib
  cp -PRv $LIBS_COPY $INSTALL/usr/lib
}

post_install() {
  enable_service unbind-console.service
}
