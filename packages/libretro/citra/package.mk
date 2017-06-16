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

PKG_NAME="citra"
PKG_VERSION="d9092f5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="https://github.com/libretro/citra/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain boost"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="A Nintendo 3DS Emulator"
PKG_LONGDESC="A Nintendo 3DS Emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DENABLE_LIBRETRO=1 -DENABLE_SDL2=0 -DENABLE_QT=0 -DCMAKE_BUILD_TYPE=\"Release\" --target citra_libretro -DBOOST_ROOT=$(get_build_dir boost) -DTHREADS_PTHREAD_ARG=OFF -DENABLE_PRECOMPILED_HEADERS=OFF -DCMAKE_CXX_FLAGS=-fPIC -DCMAKE_C_FLAGS=-fPIC"

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp citra_libretro.so $INSTALL/usr/lib/libretro/
}
