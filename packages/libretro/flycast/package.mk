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

PKG_NAME="flycast"
PKG_VERSION="11c4008"
PKG_REV="1"
PKG_ARCH="arm aarch64 x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/flycast"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_LONGDESC="Flycast is a multiplatform Sega Dreamcast emulator"
PKG_BUILD_FLAGS="-lto"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

make_target() {
  if [ "$OPENGL_SUPPORT" = yes ]; then
    if [ "$ARCH" = "arm" ]; then
      make HAVE_OPENMP=0 LDFLAGS=-lrt
    else
      make AS=${AS} CC_AS=${AS} ARCH=${ARCH} HAVE_OPENMP=0 LDFLAGS=-lrt
    fi
  else
    FLYCAST_GL=""
    [ "$OPENGLES_SUPPORT" = yes ] && FLYCAST_GL="FORCE_GLES=1"
    if [ "$ARCH" == "arm" ]; then
      if [ "$DEVICE" = "RPi4" ]; then
        make AS=${AS} CC_AS=${CC} platform=rpi4-gles-neon HAVE_OPENMP=0 LDFLAGS=-lrt
      elif [ "$DEVICE" = "RPi2" ]; then
        make AS=${AS} CC_AS=${CC} platform=rpi $FLYCAST_GL HAVE_OPENMP=0 LDFLAGS=-lrt
      elif [ "$DEVICE" = "OdroidGoAdvance" ]; then
        make AS=${AS} CC_AS=${CC} platform=classic_armv8_a35 $FLYCAST_GL HAVE_OPENMP=0 LDFLAGS=-lrt
      else
        make AS=${AS} CC_AS=${CC} platform=armv-gles-neon $FLYCAST_GL HAVE_OPENMP=0 LDFLAGS=-lrt
      fi
    else
      make AS=${AS} CC_AS=${AS} ARCH=${ARCH} $FLYCAST_GL HAVE_OPENMP=0 LDFLAGS=-lrt
    fi
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp flycast_libretro.so $INSTALL/usr/lib/libretro/
}
