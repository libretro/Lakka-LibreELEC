# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="opengl-meson"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/filesystem/"
case $MESON_FAMILY in
  8)
    PKG_VERSION="8-r5p1-02rel0-armhf"
    PKG_SHA256="717739c9f65f6782e3185aad09d01f228873315f70f9a58c0526b9e63a6e386f"
    ;;
  6)
    PKG_VERSION="6-r5p1-02rel0-armhf"
    PKG_SHA256="de38a1fa23191bd5de5c85c66627d4537775ee4634b71baa8d0e241b8b9d4ba2"
    ;;
  gxbb)
    if [ "$TARGET_ARCH" = "arm" ]; then
      PKG_VERSION="8-r5p1-02rel0-armhf"
      PKG_SHA256="717739c9f65f6782e3185aad09d01f228873315f70f9a58c0526b9e63a6e386f"
    else
      PKG_VERSION="gxbb-r5p1-01rel0"
    fi
;;
esac
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="OpenGL ES pre-compiled libraries for Mali GPUs found in Amlogic Meson SoCs."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PR usr/include/* $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR usr/lib/libMali.so $SYSROOT_PREFIX/usr/lib

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libEGL.so.1.4
    ln -sf libEGL.so.1.4 $SYSROOT_PREFIX/usr/lib/libEGL.so.1
    ln -sf libEGL.so.1 $SYSROOT_PREFIX/usr/lib/libEGL.so

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1.1
    ln -sf libGLESv1_CM.so.1.1 $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1 $SYSROOT_PREFIX/usr/lib/libGLESv1_CM.so

    ln -sf libMali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2.0
    ln -sf libGLESv2.so.2.0 $SYSROOT_PREFIX/usr/lib/libGLESv2.so.2
    ln -sf libGLESv2.so.2 $SYSROOT_PREFIX/usr/lib/libGLESv2.so

  mkdir -p $INSTALL/usr/lib
    cp -PR usr/lib/libMali.so $INSTALL/usr/lib

    ln -sf libMali.so $INSTALL/usr/lib/libEGL.so.1.4
    ln -sf libEGL.so.1.4 $INSTALL/usr/lib/libEGL.so.1
    ln -sf libEGL.so.1 $INSTALL/usr/lib/libEGL.so

    ln -sf libMali.so $INSTALL/usr/lib/libGLESv1_CM.so.1.1
    ln -sf libGLESv1_CM.so.1.1 $INSTALL/usr/lib/libGLESv1_CM.so.1
    ln -sf libGLESv1_CM.so.1 $INSTALL/usr/lib/libGLESv1_CM.so

    ln -sf libMali.so $INSTALL/usr/lib/libGLESv2.so.2.0
    ln -sf libGLESv2.so.2.0 $INSTALL/usr/lib/libGLESv2.so.2
    ln -sf libGLESv2.so.2 $INSTALL/usr/lib/libGLESv2.so
}

post_install() {
  enable_service unbind-console.service
}
