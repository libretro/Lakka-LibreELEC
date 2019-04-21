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

PKG_NAME="ppsspp"
PKG_VERSION="091c475"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Libretro port of PPSSPP"
PKG_LONGDESC="A fast and portable PSP emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
PKG_USE_CMAKE="no"

pre_configure_target() {
  strip_lto
}

make_target() {
  cd $PKG_BUILD/libretro
  if [ "$OPENGLES" == "gpu-viv-bin-mx6q" -o "$OPENGLES" == "imx-gpu-viv" ]; then
    CFLAGS="$CFLAGS -DLINUX -DEGL_API_FB"
    CXXFLAGS="$CXXFLAGS -DLINUX -DEGL_API_FB"
  fi
  if [ "$OPENGLES" == "bcm2835-driver" ]; then
    CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads"
    CXXFLAGS="$CXXFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads"
  fi
  if [ "$ARCH" == "arm" ]; then
    if [ "$OPENGLES_SUPPORT" = "yes" ]; then
      PPSSPPGLES="-gles"
    else
      PPSSPPGLES=""
    fi
    SYSROOT_PREFIX=$SYSROOT_PREFIX AS=${CXX} make platform=armv$PPSSPPGLES-neon
  elif [ "$ARCH" == "aarch64" ]; then
    if [ "$OPENGL" == "no" ]; then 
      SYSROOT_PREFIX=$SYSROOT_PREFIX AS=${CXX} make platform=arm64-neon-gles
    else
      SYSROOT_PREFIX=$SYSROOT_PREFIX AS=${CXX} make platform=arm64-neon
    fi
  else
    make
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp ../libretro/ppsspp_libretro.so $INSTALL/usr/lib/libretro/
}
