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

PKG_NAME="play"
PKG_VERSION="0043c9a"
PKG_REV="1"
PKG_ARCH="any"
PKG_SITE="https://github.com/libretro/Play-"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain curl"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Play! - PlayStation 2 Emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_USE_CMAKE="yes"

PKG_CMAKE_SCRIPT="$PKG_BUILD/CMakeLists.txt"

PKG_CMAKE_OPTS_TARGET="-DBUILD_LIBRETRO_CORE=ON -DBUILD_PLAY=OFF -DBUILD_TESTS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_C_COMPILER=${CC}"

pre_patch() {
  cd $PKG_BUILD/deps/Dependencies/boost-cmake
  wget "https://github.com/jpd002/boost-cmake/releases/download/v1.68.0/boost_1_68_0.tar.xz" --no-check-certificate

  dos2unix $PKG_BUILD/Source/ui_libretro/SH_LibreAudio.cpp
}

pre_make_target() {
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/.$TARGET_NAME/Source/ui_libretro/play_libretro.so $INSTALL/usr/lib/libretro/
}
