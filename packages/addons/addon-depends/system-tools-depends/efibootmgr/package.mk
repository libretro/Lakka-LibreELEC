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

PKG_NAME="efibootmgr"
PKG_VERSION="95f7a63"
PKG_SHA256="a6f936508c5b50b6fb5693dd2f0db911da298da0f72ffc0e2e74b09b22592fd1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/vathpela/efibootmgr"
PKG_URL="https://github.com/vathpela/efibootmgr-devel/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="efibootmgr-devel-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain efivar pciutils zlib"
PKG_SECTION="tools"
PKG_SHORTDESC="EFI Boot Manager"
PKG_LONGDESC="This is a Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager configuration. This application can create and destroy boot entries, change the boot order, change the next running boot option, and more."
PKG_BUILD_FLAGS="-lto"

pre_make_target() {
  export EXTRA_CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/include/efivar -fgnu89-inline"
  export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib -ludev -ldl"
}

makeinstall_target() {
  : # nop
}
