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

PKG_NAME="tic80"
PKG_VERSION="a204059"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/TIC-80"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="TIC-80 is a fantasy computer for making, playing and sharing tiny games."
PKG_LONGDESC="TIC-80 is a fantasy computer for making, playing and sharing tiny games."
PKG_TOOLCHAIN="cmake"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_package() {
  PKG_CMAKE_SCRIPT="$PKG_BUILD/core/CMakeLists.txt"

  PKG_CMAKE_OPTS_TARGET="-DBUILD_PLAYER=OFF \
                         -DBUILD_SDL=OFF \
                         -DBUILD_SOKOL=OFF \
                         -DBUILD_DEMO_CARTS=OFF \
                         -DBUILD_LIBRETRO=ON \
                         -DBUILD_WITH_MRUBY=OFF \
                         -DCMAKE_BUILD_TYPE=Release"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp lib/tic80_libretro.so $INSTALL/usr/lib/libretro/
}
