################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="ppsspp"
PKG_VERSION="f7ace3b"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="$PKG_SITE.git"
PKG_GIT_CLONE_BRANCH="v1.11-hotfixes"
PKG_DEPENDS_TARGET="toolchain libzip libpng"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Libretro port of PPSSPP"
PKG_LONGDESC="A fast and portable PSP emulator"
PKG_BUILD_FLAGS="-lto"
PKG_TOOLCHAIN="cmake"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DUSE_FFMPEG=ON \
                       -DUSE_SYSTEM_FFMPEG=OFF \
                       -DUSE_DISCORD=OFF \
                       -DUSE_MINIUPNPC=OFF \
                       --target ppsspp_libretro"

if [ "$OPENGL_SUPPORT" = no -a "$OPENGLES_SUPPORT" = yes ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSING_GLES2=ON"
fi

if [ "$VULKAN_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DVULKAN=ON"
  if [ "$DISPLAYSERVER" = "x11" ]; then
    PKG_CMAKE_OPTS_TARGET+=" -DUSING_X11_VULKAN=ON"
  else
    PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN_DISPLAY_KHR=ON -DUSING_X11_VULKAN=OFF"
  fi
fi

if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DARMV7=ON"
elif [ "$TARGET_ARCH" = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DARM64=ON"
fi

pre_make_target() {
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find $PKG_BUILD -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp lib/ppsspp_libretro.so $INSTALL/usr/lib/libretro/
  mkdir -p $INSTALL/usr/share/retroarch-system/PPSSPP
  cp -R $PKG_BUILD/assets/* $INSTALL/usr/share/retroarch-system/PPSSPP/
}
