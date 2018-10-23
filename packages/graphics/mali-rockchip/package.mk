# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mali-rockchip"
PKG_VERSION="12daf22c405a4f8faf6cbc4d2e88b85b36dc61d9"
PKG_SHA256="e6004e0f5a8a4aba098d301b3f964e2a9a961bb79f180d55ea6e9e73cd6eb874"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/libmali"
PKG_URL="https://github.com/rockchip-linux/libmali/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="mali-rockchip: OpenGL ES user-space binary for the ARM Mali GPU family"
PKG_TOOLCHAIN="manual"

if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_MALI_ARCH="arm-linux-gnueabihf"
elif [ "$TARGET_ARCH" = "aarch64" ]; then
  PKG_MALI_ARCH="aarch64-linux-gnu"
fi

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_MALI_SUFFIX=""
elif [ "$DISPLAYSERVER" = "weston" ]; then
  PKG_MALI_SUFFIX="-wayland"
else
  PKG_MALI_SUFFIX="-gbm"
fi

if [ "$MALI_FAMILY" = "t760" -a "$MALI_REVISION" = "r1p0" ]; then
  PKG_MALI_FILE="libmali-midgard-t76x-r14p0-r1p0$PKG_MALI_SUFFIX.so"
elif [ "$MALI_FAMILY" = "t760" ]; then
  PKG_MALI_FILE="libmali-midgard-t76x-r14p0-r0p0$PKG_MALI_SUFFIX.so"
elif [ "$MALI_FAMILY" = "t860" ]; then
  PKG_MALI_FILE="libmali-midgard-t86x-r14p0$PKG_MALI_SUFFIX.so"
elif [ "$MALI_FAMILY" = "450" ]; then
  PKG_MALI_FILE="libmali-utgard-450-r7p0$PKG_MALI_SUFFIX.so"
elif [ "$MALI_FAMILY" = "400" ]; then
  PKG_MALI_FILE="libmali-utgard-400-r7p0$PKG_MALI_SUFFIX.so"
else
  echo "ERROR: Unknown MALI_FAMILY '$MALI_FAMILY', aborting."
  exit 1
fi

configure_target() {
  if [ ! -f "$PKG_BUILD/lib/$PKG_MALI_ARCH/$PKG_MALI_FILE" ]; then
    echo "ERROR: $PKG_MALI_ARCH/$PKG_MALI_FILE does not exist, aborting."
    exit 1
  fi
}

makeinstall_target() {
  cd $PKG_BUILD

  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PRv include/EGL $SYSROOT_PREFIX/usr/include
    cp -PRv include/GLES $SYSROOT_PREFIX/usr/include
    cp -PRv include/GLES2 $SYSROOT_PREFIX/usr/include
    if [ "$MALI_FAMILY" = "t760" -o "$MALI_FAMILY" = "t860" ]; then
      cp -PRv include/GLES3 $SYSROOT_PREFIX/usr/include
    fi
    cp -PRv include/KHR $SYSROOT_PREFIX/usr/include
    cp -PRv include/gbm.h $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp -PRv $PKG_DIR/pkgconfig/*.pc $SYSROOT_PREFIX/usr/lib/pkgconfig
    if [ "$DISPLAYSERVER" != "weston" ]; then
      rm -fv $SYSROOT_PREFIX/usr/lib/pkgconfig/wayland-egl.pc
    fi

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PRv lib/$PKG_MALI_ARCH/$PKG_MALI_FILE $SYSROOT_PREFIX/usr/lib
    ln -sfv $PKG_MALI_FILE $SYSROOT_PREFIX/usr/lib/libmali.so
    ln -sfv libmali.so $SYSROOT_PREFIX/usr/lib/libMali.so
    ln -sfv libmali.so $SYSROOT_PREFIX/usr/lib/libEGL.so
    ln -sfv libmali.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so
    ln -sfv libmali.so $SYSROOT_PREFIX/usr/lib/libgbm.so

  mkdir -p $INSTALL/usr/lib
    cp -PRv lib/$PKG_MALI_ARCH/$PKG_MALI_FILE $INSTALL/usr/lib
    ln -sfv $PKG_MALI_FILE $INSTALL/usr/lib/libmali.so
    ln -sfv libmali.so $INSTALL/usr/lib/libMali.so
    ln -sfv libmali.so $INSTALL/usr/lib/libEGL.so
    ln -sfv libmali.so $INSTALL/usr/lib/libEGL.so.1
    ln -sfv libmali.so $INSTALL/usr/lib/libGLESv2.so
    ln -sfv libmali.so $INSTALL/usr/lib/libGLESv2.so.2
    ln -sfv libmali.so $INSTALL/usr/lib/libgbm.so
}
