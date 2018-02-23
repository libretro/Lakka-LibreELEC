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

PKG_NAME="efivar"
PKG_VERSION="70e63d4"
# 0.15 # Todo: later versions with buildproblems
PKG_SHA256="2638f1faa22e67bf99b4c537f7c21c336a5851a8c91c8dc09555da946a1b84c9"
PKG_ARCH="x86_64"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/vathpela/efivar"
PKG_URL="https://github.com/vathpela/efivar-devel/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="efivar-devel-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain efivar:host"
PKG_SECTION="tools"
PKG_SHORTDESC="evivar: maniulate EFI Variables"
PKG_LONGDESC="Tools and library to manipulate EFI variables."
PKG_BUILD_FLAGS="-lto"

make_host() {
  make -C src/ makeguids
}

make_target() {
  make -C src/ libefivar.a efivar-guids.h efivar.h
}

makeinstall_host() {
  : # noop
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -P src/libefivar.a $SYSROOT_PREFIX/usr/lib/

  mkdir -p $SYSROOT_PREFIX/usr/include/efivar
    cp -P src/efivar.h $SYSROOT_PREFIX/usr/include/efivar
    cp -P src/efivar-guids.h $SYSROOT_PREFIX/usr/include/efivar
}
