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

PKG_NAME="wasm4"
PKG_VERSION="6e01840"
PKG_ARCH="any"
PKG_LICENSE="ISC"
PKG_SITE="https://github.com/aduros/wasm4"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="WASM-4 is a low-level fantasy game console for building small games with WebAssembly."
PKG_LONGDESC="WASM-4 is a low-level fantasy game console for building small games with WebAssembly."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_TOOLCHAIN="cmake"

configure_package() {
  PKG_CMAKE_SCRIPT="$PKG_BUILD/runtimes/native/CMakeLists.txt"
  PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=on \
                         -DCMAKE_BUILD_TYPE=Release"
}

pre_make_target() {
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find $PKG_BUILD -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp wasm4_libretro.so $INSTALL/usr/lib/libretro/
}

