# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libglvnd"
PKG_VERSION="1.3.2"
PKG_SHA256="6f41ace909302e6a063fd9dc04760b391a25a670ba5f4b6edf9e30f21410b673"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NVIDIA/libglvnd"
PKG_URL="https://github.com/NVIDIA/libglvnd/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11 libXext xorgproto"
PKG_LONGDESC="libglvnd is a vendor-neutral dispatch layer for arbitrating OpenGL API calls between multiple vendors."

if [ ! "${PROJECT}" = "L4T" ]; then
  if [ "${OPENGLES_SUPPORT}" = "no" ]; then
    PKG_MESON_OPTS_TARGET="-Dgles1=false \
                           -Dgles2=false"
  fi
else
  PKG_MESON_OPTS_TARGET="-Dheaders=true \
                         -Dx11=enabled \
                         -Degl=true \
                         -Dglx=enabled \
                         -Dgles1=true \
                         -Dgles2=true"
fi

post_makeinstall_target() {
  if [ ! "${PROJECT}" = "L4T" ]; then
    if [ "${DISPLAYSERVER}" = "x11" ]; then
      # Remove old symlinks to GLVND libGL.so.1.7.0
      safe_remove              ${INSTALL}/usr/lib/libGL.so
      safe_remove              ${INSTALL}/usr/lib/libGL.so.1
      # Create new symlinks to /var/lib/libGL.so
      ln -sf libGL.so.1        ${INSTALL}/usr/lib/libGL.so
      ln -sf /var/lib/libGL.so ${INSTALL}/usr/lib/libGL.so.1
      # Create new symlink to GLVND libGL.so.1.7.0
      ln -sf libGL.so.1.7.0    ${INSTALL}/usr/lib/libGL_glvnd.so.1
    fi
  fi
}
