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

PKG_NAME="imx-gpu-viv"
if [ "$LINUX" = "imx6-3.14-sr" ]; then
  PKG_VERSION="5.0.11.p4.5-hfp"
elif [ "$LINUX" = "imx6-4.4-xbian" ]; then
  PKG_VERSION="5.0.11.p7.4-hfp"
elif [ "$LINUX" = "imx6-4.9-wb" ]; then
  PKG_VERSION="6.2.2.p0-aarch32"
else
  exit 0
fi
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.freescale.com"
if [ "$PKG_VERSION" = "5.0.11.p7.4-hfp" ]; then
  PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
else
  PKG_URL="http://repository.timesys.com/buildsources/i/imx-gpu-viv/imx-gpu-viv-${PKG_VERSION//-*/}/imx-gpu-viv-$PKG_VERSION.bin"
fi
PKG_DEPENDS_TARGET="toolchain"
if [ "$PKG_VERSION" = "6.2.2.p0-aarch32" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET \
                      imx-gpu-g2d"
fi
PKG_SECTION="graphics"
PKG_SHORTDESC="imx-gpu-viv: OpenGL-ES and VIVANTE driver for imx6q"
PKG_LONGDESC="imx-gpu-viv: OpenGL-ES and VIVANTE driver for imx6q"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
 : # nothing to make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
  cp -PRv gpu-core/usr/include/* $SYSROOT_PREFIX/usr/include

  if [ "$PKG_VERSION" = "5.0.11.p4.5-hfp" -o "$PKG_VERSION" = "5.0.11.p7.4-hfp" ]; then
    cp -PRv g2d/usr/include/* $SYSROOT_PREFIX/usr/include
  fi

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
             gpu-core/usr/lib/libOpenCL.so \
             gpu-core/usr/lib/libVSC.so"

  if [ "$PKG_VERSION" = "5.0.11.p4.5-hfp" -o "$PKG_VERSION" = "5.0.11.p7.4-hfp" ]; then
    LIBS_COPY="$LIBS_COPY \
               gpu-core/usr/lib/libVIVANTE-fb.so \
               gpu-core/usr/lib/libVIVANTE.so* \
               g2d/usr/lib/libg2d*.so*"
  fi

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
