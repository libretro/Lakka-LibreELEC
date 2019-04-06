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
PKG_VERSION="d4543ac"
PKG_REV="1"
PKG_ARCH="none"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/lakka-switch/citra"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain boost"
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
                       -DTHREADS_PTHREAD_ARG=OFF \
                       -DCMAKE_NO_SYSTEM_FROM_IMPORTED=1 \
                       -DCMAKE_VERBOSE_MAKEFILE=1 \
                       --target citra_libretro"

PKG_COPY_HEADER_FILES="stdlib.h math.h"

pre_configure_target() {
  if [ -n "$PKG_COPY_HEADER_FILES" ] ; then
    for x in $PKG_COPY_HEADER_FILES ; do
      cp -v $SYSROOT_PREFIX/usr/include/$x $TOOLCHAIN/$TARGET_NAME/include/
    done
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp src/citra_libretro/citra_libretro.so $INSTALL/usr/lib/libretro/
}

post_makeinstall_target() {
  if [ -n "$PKG_COPY_HEADER_FILES" ] ; then
    for x in $PKG_COPY_HEADER_FILES ; do
      rm -vf $TOOLCHAIN/$TARGET_NAME/include/$x
    done
  fi
}
