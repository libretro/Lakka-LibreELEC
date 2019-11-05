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
PKG_VERSION="84f31e9"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/citra"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain boost curl"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="A Nintendo 3DS Emulator"
PKG_LONGDESC="A Nintendo 3DS Emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DENABLE_LIBRETRO=1 \
                       -DENABLE_SDL2=0 \
                       -DENABLE_QT=0 \
                       -DCMAKE_BUILD_TYPE=\"Release\" \
                       -DBOOST_ROOT=$(get_build_dir boost) \
                       -DUSE_SYSTEM_CURL=1 \
                       -DTHREADS_PTHREAD_ARG=OFF \
                       -DCMAKE_NO_SYSTEM_FROM_IMPORTED=1 \
                       -DCMAKE_VERBOSE_MAKEFILE=1 \
                       --target citra_libretro"

pre_make_target() {
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp src/citra_libretro/citra_libretro.so $INSTALL/usr/lib/libretro/
}
