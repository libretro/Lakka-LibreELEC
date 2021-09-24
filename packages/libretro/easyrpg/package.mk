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

PKG_NAME="easyrpg"
PKG_VERSION="4dd00a6"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/EasyRPG/Player"
PKG_GIT_CLONE_BRANCH="0-6-2-stable"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain zlib libfmt liblcf pixman libspeexdsp mpg123 libsndfile libvorbis opusfile wildmidi libxmp-lite"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="An unofficial libretro port of the EasyRPG/Player."
PKG_LONGDESC="An unofficial libretro port of the EasyRPG/Player."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DPLAYER_TARGET_PLATFORM=libretro \
                       -DPLAYER_WITH_FREETYPE=OFF \
                       -DBUILD_SHARED_LIBS=ON \
                       -DCMAKE_BUILD_TYPE=Release"

pre_make_taget() {
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find $PKG_BUILD -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/.$TARGET_NAME/easyrpg_libretro.so $INSTALL/usr/lib/libretro/
}
