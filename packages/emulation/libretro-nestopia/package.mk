# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-nestopia"
PKG_VERSION="faf19f8e64baa09059201d40f09621f820453fca"
PKG_SHA256="b22a362ddd3ae25151e53ed3ae0dc429cd402ba99ac43f08d061b5def0c807ce"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/nestopia"
PKG_URL="https://github.com/libretro/nestopia/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="nestopia-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.nestopia: Nestopia for Kodi"
PKG_LONGDESC="game.libretro.nestopia: Nestopia for Kodi"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="nestopia_libretro.so"
PKG_LIBPATH="libretro/$PKG_LIBNAME"
PKG_LIBVAR="NESTOPIA_LIB"

post_unpack() {
  rm $PKG_BUILD/configure.ac
}

make_target() {
  make -C libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
