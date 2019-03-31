# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmali"
PKG_VERSION="74c27b4b401e3266c71ab3718ef9878bd36dbd34"
PKG_SHA256="3a4d9295a5539fcaa470a5f0cdeda794be604842ff2c2936f2aab33ccf50bc2d"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/LibreELEC/libmali"
PKG_URL="https://github.com/LibreELEC/libmali/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="OpenGL ES user-space binary for the ARM Mali GPU family"

PKG_DEPENDS_TARGET="libdrm"

if [ "$MALI_FAMILY" = "t620" -o "$MALI_FAMILY" = "t720" -o "$MALI_FAMILY" = "g52" ]; then
  PKG_DEPENDS_TARGET+=" wayland"
fi

PKG_CMAKE_OPTS_TARGET="-DMALI_VARIANT=$MALI_FAMILY"

if [ -n "$MALI_REVISION" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DMALI_REVISION=$MALI_REVISION"
fi

if [ "$TARGET_ARCH" = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DMALI_ARCH=aarch64-linux-gnu"
fi
