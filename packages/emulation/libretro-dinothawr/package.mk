################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libretro-dinothawr"
PKG_VERSION="fbb3a75"
PKG_SHA256="f82882d185a8dd357a0da1bac6062e056c4ac3719054d7bb0a826fc2dd5c6b3d"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/Dinothawr"
PKG_URL="https://github.com/libretro/Dinothawr/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="Dinothawr-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.dinothawr: dinothawr for Kodi"
PKG_LONGDESC="game.libretro.dinothawr: dinothawr for Kodi"

PKG_LIBNAME="dinothawr_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="DINOTHAWR_LIB"

pre_make_target() {
  if target_has_feature neon; then
    export HAVE_NEON=1
  fi
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
