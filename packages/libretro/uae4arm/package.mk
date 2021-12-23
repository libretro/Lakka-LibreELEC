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

PKG_NAME="uae4arm"
PKG_VERSION="96fd90b"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/Chips-fr/uae4arm-rpi"
PKG_GIT_CLONE_BRANCH="master"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain flac mpg123 zlib"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Port of uae4arm for libretro (rpi/android)"
PKG_LONGDESC="Port of uae4arm for libretro (rpi/android) "

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"


make_target() {
  if [[ "$ARCH" =~ "aarch64" ]]; then
    make -f Makefile.libretro platform=unix-aarch64
  else
    if [[ "$TARGET_FPU" =~ "neon" ]]; then
      make -f Makefile.libretro platform=unix-neon
    else
      make -f Makefile.libretro platform=unix
    fi
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp uae4arm_libretro.so $INSTALL/usr/lib/libretro/
  cp capsimg.so $INSTALL/usr/lib/
}
