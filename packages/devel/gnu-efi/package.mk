################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="gnu-efi"
PKG_VERSION="3.0"
PKG_VERSION_SRC="${PKG_VERSION}u"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/gnu-efi/"
PKG_URL="$SOURCEFORGE_SRC/project/$PKG_NAME/${PKG_NAME}_${PKG_VERSION_SRC}.orig.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="gnu-efi: Library for building UEFI Applications using GNU toolchain"
PKG_LONGDESC="gnu-efi is a library for building UEFI Applications using GNU toolchain"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
# Unset all compiler FLAGS
  unset CFLAGS
  unset CPPFLAGS
  unset CXXFLAGS
  unset LDFLAGS

  export MAKEFLAGS=-j1

  if  [ "$TARGET_ARCH" = "x86_64" ]; then
    EFI_ARCH="x86_64"
  elif [ "$TARGET_ARCH" = "i386" ]; then
    EFI_ARCH="ia32"
  fi
}

make_target() {
  make CC=$CC ARCH=$EFI_ARCH
  make CC=$CC ARCH=$EFI_ARCH -C apps all
}

makeinstall_target() {
  make ARCH=$EFI_ARCH INSTALLROOT="$SYSROOT_PREFIX" PREFIX="/usr" LIBDIR="/usr/lib" install
  mkdir -p $INSTALL/usr/share/gnu-efi/apps/$EFI_ARCH
    cp apps/*.efi $INSTALL/usr/share/gnu-efi/apps/$EFI_ARCH
}
