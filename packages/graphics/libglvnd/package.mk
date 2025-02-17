# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libglvnd"
PKG_VERSION="1.7.0"
PKG_SHA256="073e7292788d4d3eeb45ea6c7bdcce9bfdb3b3eef8d7dbd47f2f30dce046ef98"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NVIDIA/libglvnd"
PKG_URL="https://github.com/NVIDIA/libglvnd/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libglvnd is a vendor-neutral dispatch layer for arbitrating OpenGL API calls between multiple vendors."

configure_package() {
  if [ "${DISPLAYSERVER}" = "x11" -o "${DISTRO}" = "Lakka" ]; then
    PKG_DEPENDS_TARGET+=" libX11 libXext xorgproto"
  fi
}

pre_configure_target(){
  if [ ! "${PROJECT}" = "L4T" -a "${PROJECT}" = "Ayn" ]; then
    PKG_MESON_OPTS_TARGET="-Dgles1=false"

    if [ "${OPENGLES_SUPPORT}" = "no" ]; then
      PKG_MESON_OPTS_TARGET+=" -Dgles2=false"
    fi
  else
    PKG_MESON_OPTS_TARGET="-Dheaders=true \
                           -Dx11=enabled \
                           -Degl=true \
                           -Dglx=enabled \
                           -Dgles1=true \
                           -Dgles2=true"
  fi

  if [ "${DEVICE}" = "Odin" ]; then
    PKG_MESON_OPTS_TARGET="-Dheaders=true \
                           -Dx11=enabled \
                           -Degl=true \
                           -Dglx=enabled \
                           -Dgles1=true \
                           -Dgles2=true"
  fi
}

post_makeinstall_target() {
  if [ ! "${PROJECT}" = "L4T" -a ! "${PROJECT}" = "Ayn" ]; then
    if [ "${DISPLAYSERVER}" = "x11" ]; then
      # Remove old symlinks to libGL.so.1.7.0 (GLVND)
      safe_remove              ${INSTALL}/usr/lib/libGL.so
      safe_remove              ${INSTALL}/usr/lib/libGL.so.1
      # Create new symlinks to /var/lib/libGL.so
      ln -sf libGL.so.1        ${INSTALL}/usr/lib/libGL.so
      ln -sf /var/lib/libGL.so ${INSTALL}/usr/lib/libGL.so.1
      # Create new symlink to libGL.so.1.7.0
      ln -sf libGL.so.1.7.0    ${INSTALL}/usr/lib/libGL_glvnd.so.1

      # Remove old symlinks to libGLX.so.0.0.0 (GLVND)
      safe_remove               ${INSTALL}/usr/lib/libGLX.so
      safe_remove               ${INSTALL}/usr/lib/libGLX.so.0
      # Create new symlinks to /var/lib/libGLX.so
      ln -sf libGLX.so.0        ${INSTALL}/usr/lib/libGLX.so
      ln -sf /var/lib/libGLX.so ${INSTALL}/usr/lib/libGLX.so.0
      # Create new symlink to libGLX.so.0.0.0
      ln -sf libGLX.so.0.0.0    ${INSTALL}/usr/lib/libGLX_glvnd.so.0
      # indirect rendering
      ln -sf /var/lib/libGLX_indirect.so.0 ${INSTALL}/usr/lib/libGLX_indirect.so.0
    fi
  fi
}
