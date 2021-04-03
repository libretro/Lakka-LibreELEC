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

PKG_NAME="parallel-n64"
PKG_VERSION="0a67445"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-n64"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Optimized/rewritten Nintendo 64 emulator made specifically for Libretro. Originally based on Mupen64 Plus."
PKG_LONGDESC="Optimized/rewritten Nintendo 64 emulator made specifically for Libretro. Originally based on Mupen64 Plus."
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
  DYNAREC=$ARCH

  if [ "$ARCH" == "i386" ]; then
    DYNAREC=x86
  fi

  if [ "$ARCH" = "arm" -o "$ARCH" = "aarch64" ]; then
    CFLAGS="$CFLAGS -DARM_FIX"
  fi

  if [ "$DEVICE" == "RPi" -o "$DEVICE" == "Gamegirl" ]; then
    make platform=rpi
  elif [ "$DEVICE" = "RPi4" ]; then
    LDFLAGS="$LDFLAGS -lpthread"
    if [ "$ARCH" = "aarch64" ]; then
      make WITH_DYNAREC=$DYNAREC FORCE_GLES=1 HAVE_PARALLEL=1
    else
      make platform=armv-neon WITH_DYNAREC=$DYNAREC HAVE_PARALLEL=1
    fi
  elif [[ "$PROJECT" == "Generic_VK_nvidia" ]]; then
    LDFLAGS="$LDFLAGS -lpthread"
    make WITH_DYNAREC=$DYNAREC HAVE_PARALLEL=1 HAVE_OPENGL=0
  elif [[ "$TARGET_FPU" =~ "neon" ]]; then
    CFLAGS="$CFLAGS -DGL_BGRA_EXT=0x80E1" # Fix build for platforms where GL_BGRA_EXT is not defined
    make platform=armv-gles-neon
  elif [ "$PROJECT" ==  "Rockchip" -a "$ARCH" == "aarch64" ]; then
    LDFLAGS="$LDFLAGS -lpthread"
    make FORCE_GLES=1 HAVE_PARALLEL=1
  else
    LDFLAGS="$LDFLAGS -lpthread"
    make WITH_DYNAREC=$DYNAREC HAVE_PARALLEL=0
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp parallel_n64_libretro.so $INSTALL/usr/lib/libretro/
}
