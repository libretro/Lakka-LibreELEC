# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="odroidxu3-mali"
PKG_VERSION="r12p004rel0linux1wayland"
PKG_SHA256="3ee685c8eab7fe440cb07ebff0d178ff8cc00a1215f58b29bd09cb3cae751cb1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://malideveloper.arm.com/resources/drivers/arm-mali-midgard-gpu-user-space-drivers/"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/mali-drivers/user-space/odroid-xu3/malit62xr12p004rel0linux1wayland.tar.gz"
PKG_SOURCE_DIR="wayland"
PKG_DEPENDS_TARGET="libdrm wayland mali-opengl-es-sdk"
PKG_LONGDESC="Mali-t62x blobs for Odroid-XU3/XU4"
PKG_TOOLCHAIN="manual"

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

