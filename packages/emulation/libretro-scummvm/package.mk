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

PKG_NAME="libretro-scummvm"
PKG_VERSION="93d1ca12b6"
PKG_SHA256="5a39e30bda47fe6b71e3f7ef05e91eda20dea001f7ebbe47b5a7579fadaf8178"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="https://github.com/libretro/scummvm/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="scummvm-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.scummvm: scummvm for Kodi"
PKG_LONGDESC="game.libretro.scummvm: scummvm for Kodi"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-lto"

PKG_LIBNAME="scummvm_libretro.so"
PKG_LIBPATH="backends/platform/libretro/build/$PKG_LIBNAME"
PKG_LIBVAR="SCUMMVM_LIB"

make_target() {
  cd $PKG_BUILD
  CXXFLAGS="$CXXFLAGS -DHAVE_POSIX_MEMALIGN=1"
  export AR="$AR cru"
  make -C backends/platform/libretro/build/
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
