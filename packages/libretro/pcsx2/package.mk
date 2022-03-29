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

PKG_NAME="pcsx2"
PKG_VERSION="c68ba0b"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx2"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="libaio toolchain xz"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="PCSX2 is a free and open-source PlayStation 2 (PS2) emulator"
PKG_LONGDESC="PCSX2 is a free and open-source PlayStation 2 (PS2) emulator"
PKG_TOOLCHAIN="cmake"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
		       -DENABLE_QT=OFF \
		       -DCMAKE_BUILD_TYPE=Release"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

pre_make_target() {
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find $PKG_BUILD -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}


makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp pcsx2/pcsx2_libretro.so $INSTALL/usr/lib/libretro/
}

