# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Lakka Team)

PKG_NAME="swanstation"
PKG_VERSION="8951ed1"
PKG_LICENSE="GPL-3.0-or-later"
PKG_SITE="https://github.com/libretro/swanstation"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="SwanStation(DuckStation) is an simulator/emulator of the Sony PlayStation(TM) console, focusing on playability, speed, and long-term maintainability."

if [ "$OPENGL_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

if [ "$VULKAN_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $VULKAN"
fi

PKG_CMAKE_OPTS_TARGET="-DBUILD_NOGUI_FRONTEND=OFF \
                       -DBUILD_QT_FRONTEND=OFF \
                       -DBUILD_LIBRETRO_CORE=ON \
                       -DENABLE_DISCORD_PRESENCE=OFF \
                       -DUSE_DRMKMS=ON \
                       -DUSE_SDL2=OFF"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp swanstation_libretro.so $INSTALL/usr/lib/libretro/
}
