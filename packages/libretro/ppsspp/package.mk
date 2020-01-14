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
PKG_VERSION="e717366"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain ffmpeg"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Libretro port of PPSSPP"
PKG_LONGDESC="A fast and portable PSP emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_USE_CMAKE="yes"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=yes \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DUSE_FFMPEG=yes \
                       -DUSE_SYSTEM_FFMPEG=yes \
                       --target ppsspp_libretro"

if [ "$OPENGL_SUPPORT" = no -a "$OPENGLES_SUPPORT" = yes ]; then
  PKG_CMAKE_OPTS_TARGET="-DUSING_GLES2=yes $PKG_CMAKE_OPTS_TARGET"
fi

if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_CMAKE_OPTS_TARGET="-DARMV7=yes $PKG_CMAKE_OPTS_TARGET"
elif [ "$TARGET_ARCH" = "aarch64" ]; then
  PKG_CMAKE_OPTS_TARGET="-DARM64=yes $PKG_CMAKE_OPTS_TARGET"
fi

pre_configure_target() {
  strip_lto
}

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
