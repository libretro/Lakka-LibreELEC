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

PKG_NAME="mame"
PKG_VERSION="aedbec9"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="MAME - Multiple Arcade Machine Emulator"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  strip_gold
  strip_lto

  LCPU=$ARCH
  PTR64=0
  NOASM=0

  if [ "$ARCH" == "arm" ]; then
    NOASM=1
  elif [ "$ARCH" == "i386" ]; then
    LCPU=x86
  elif [ "$ARCH" == "x86_64" ]; then
    PTR64=1
  fi

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="$LCPU" DISTRO="debian-stable" CC="$CC" CXX="$CXX" LD="$LD" CROSS_BUILD="" PTR64="$PTR64" TARGET="mame" SUBTARGET="arcade" PLATFORM=$LCPU RETRO=1 OSD="retro"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *_libretro.so $INSTALL/usr/lib/libretro/mame_libretro.so
}
