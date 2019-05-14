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

PKG_NAME="ishiiruka"
PKG_VERSION="60c9a09"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/lakka-switch/Ishiiruka"
PKG_GIT_BRANCH="l4t"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain cmake:host libusb ffmpeg libevdev $OPENGL"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="A Dolphin fork where the focus is on the gaming experience and speed."
PKG_LONGDESC="A Dolphin fork where the focus is on the gaming experience and speed."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_USE_CMAKE="yes"

if [ "$BLUETOOTH_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bluez"
fi

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON -DENABLE_WX=OFF"
PKG_MAKE_OPTS_TARGET="ishiiruka_libretro"

pre_make_target() {
  # build fix for cross-compiling Dolphin, from Dolphin forums
  find $PKG_BUILD -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp $PKG_BUILD/.$TARGET_NAME/Binaries/ishiiruka_libretro.so $INSTALL/usr/lib/libretro/
  cp $PKG_DIR/core_info/ishiiruka_libretro.info $INSTALL/usr/lib/libretro/
}
