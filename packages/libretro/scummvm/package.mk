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

PKG_NAME="scummvm"
PKG_VERSION="2fb2e4c"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="ScummVM with libretro backend."
PKG_LONGDESC="ScummVM is a program which allows you to run certain classic graphical point-and-click adventure games, provided you already have their data files."
PKG_BUILD_FLAGS="-lto"
PKG_TOOLCHAIN="make"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  export CXXFLAGS="$CXXFLAGS -DHAVE_POSIX_MEMALIGN=1"
  cd ../backends/platform/libretro/build/
if [ "$DEVICE" == "OdroidGoAdvance" ]; then
  make platform=oga_a35_neon_hardfloat
else
  make
fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp scummvm_libretro.so $INSTALL/usr/lib/libretro/

  # unpack files to retroarch-system folder and create basic ini file
  if [ -f $PKG_BUILD/backends/platform/libretro/aux-data/scummvm.zip ]; then
    mkdir -p $INSTALL/usr/share/retroarch-system
      unzip $PKG_BUILD/backends/platform/libretro/aux-data/scummvm.zip \
            -d $INSTALL/usr/share/retroarch-system

      cat << EOF > $INSTALL/usr/share/retroarch-system/scummvm.ini
[scummvm]
extrapath=/tmp/system/scummvm/extra
browser_lastpath=/tmp/system/scummvm/extra
themepath=/tmp/system/scummvm/theme
guitheme=scummmodern
EOF

  fi
}
