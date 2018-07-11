################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="libretro-vram-test"
PKG_VERSION="6b90ce9"
PKG_SHA256="2bd1b3af783a028355eb4b4c416f09802313a9a69759e716377b55012f7bb4ae"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-samples"
PKG_URL="https://github.com/libretro/libretro-samples/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emulation"
PKG_LONGDESC="VRAM Test from libretro"
PKG_SOURCE_DIR="libretro-samples-*"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="testsw_vram_libretro.so"
PKG_LIBPATH="$PKG_BUILD/video/software/rendering_direct_to_vram/$PKG_LIBNAME"
PKG_LIBVAR="VRAM-TEST_LIB"

make_target() {
  cd $PKG_BUILD/video/software/rendering_direct_to_vram
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
