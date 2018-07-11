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

PKG_NAME="libretro-uae4arm"
PKG_VERSION="0e9dd6e"
PKG_SHA256="ccc989c75c11cbc1be96b917cadc3551b5fb8710f2a203f2ce86c46196229a4a"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/uae4arm-libretro"
PKG_URL="https://github.com/libretro/uae4arm-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="uae4arm-libretro-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="emulation"
PKG_LONGDESC="UAE4ARM amiga emulator."

PKG_LIBNAME="uae4arm_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="UAE4ARM_LIB"

pre_configure_target() {
  if target_has_feature neon; then
    CFLAGS="$CFLAGS -D__NEON_OPT"
  fi
}

make_target() {
  make HAVE_NEON=1 USE_PICASSO96=1
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
