################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="pixman"
PKG_VERSION="0.32.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain util-macros"
PKG_PRIORITY="optional"
PKG_SECTION="x11/lib"
PKG_SHORTDESC="pixman: Pixel manipulation library"
PKG_LONGDESC="Pixman is a generic library for manipulating pixel regions, contains low-level pixel manipulation routines and is used by both xorg and cairo."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$TARGET_ARCH" = arm ]; then
  if [ "$TARGET_FPU" = neon -o "$TARGET_FPU" = neon-fp16 ]; then
    PIXMAN_NEON="--enable-arm-neon"
  else
    PIXMAN_NEON="--disable-arm-neon"
  fi
  PIXMAN_CONFIG="--disable-mmx --disable-sse2 --disable-vmx --enable-arm-simd $PIXMAN_NEON --disable-arm-iwmmxt"
elif [ "$TARGET_ARCH" = i386 -o "$TARGET_ARCH" = x86_64  ]; then
  PIXMAN_CONFIG="--enable-mmx --enable-sse2 --disable-ssse3 --disable-vmx --disable-arm-simd --disable-arm-neon"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-openmp \
                           --disable-loongson-mmi \
                           $PIXMAN_CONFIG \
                           --disable-mips-dspr2 \
                           --enable-gcc-inline-asm \
                           --disable-timers \
                           --disable-gtk \
                           --disable-libpng \
                           --with-gnu-ld"

post_makeinstall_target() {
  cp $SYSROOT_PREFIX/usr/lib/pkgconfig/pixman-1.pc \
     $SYSROOT_PREFIX/usr/lib/pkgconfig/pixman.pc
  cp -rf $SYSROOT_PREFIX/usr/include/pixman-1 \
     $SYSROOT_PREFIX/usr/include/pixman
}
