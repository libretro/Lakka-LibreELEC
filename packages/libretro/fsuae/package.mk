################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="fsuae"
PKG_VERSION="6b98f85"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-fsuae"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain libmpeg2 openal-soft glib"
PKG_SECTION="emulation"
PKG_SHORTDESC="FS-UAE amiga emulator libretro core."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

case $PROJECT in
  RPi*)
    PKG_CONFIGURE_OPTS_TARGET="--disable-jit --enable-neon"
    ;;
esac

pre_configure_target() {
  cd $BUILD/$PKG_NAME-$PKG_VERSION
  rm -rf .$TARGET_NAME
  export ac_cv_func_realloc_0_nonnull=yes
  strip_lto
}

make_target() {
  make CC=$HOST_CC CFLAGS= gen
  make CC=$CC
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp fsuae_libretro.so $INSTALL/usr/lib/libretro/
  mkdir -p $INSTALL/usr/share/fs-uae
  cp fs-uae.dat $INSTALL/usr/share/fs-uae/
}
