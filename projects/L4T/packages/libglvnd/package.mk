# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libglvnd"
PKG_VERSION="1.3.2"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NVIDIA/libglvnd"
PKG_URL="https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/v${PKG_VERSION}/libglvnd-v${PKG_VERSION}.tar"
#libXi isnt needed, but I need to push back the build for something that is around there in the build,
#and appears to break some cores if not forced to build later
PKG_DEPENDS_TARGET="toolchain libX11 libXext xorgproto tegra-bsp"
PKG_LONGDESC="libglvnd is a vendor-neutral dispatch layer for arbitrating OpenGL API calls between multiple vendors."
PKG_TOOLCHAIN="autotools"

if [ ! "${PLATFORM}" == "L4T" ]; then
  if [ "$OPENGLES_SUPPORT" = "no" ]; then
    PKG_CONFIGURE_OPTS_TARGET+=" --disable-gles"
  fi
else
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-headers --enable-x11 --enable-egl --enable-glx --enable-gles1 --enable-gles2"
fi
