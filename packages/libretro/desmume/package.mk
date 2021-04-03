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

PKG_NAME="desmume"
PKG_VERSION="7300ed8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/desmume"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="libretro wrapper for desmume NDS emulator."
PKG_LONGDESC="libretro wrapper for desmume NDS emulator."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

post_patch() {
  # enable OGL back if present
  if [ "$OPENGL_SUPPORT" = yes ]; then
    patch --reverse -d `echo "$PKG_BUILD" | cut -f1 -d\ ` -p1 < $PKG_DIR/patches/desmume-002-disable-ogl.patch
  fi
}

make_target() {
  if [ "$OPENGL_SUPPORT" = yes ]; then
    OGL=1
  else
    OGL=0
  fi

  if [ "$ARCH" == "arm" ]; then
    make -C desmume/src/frontend/libretro platform=armv LDFLAGS="$LDFLAGS -lpthread" HAVE_GL=$OGL DESMUME_OPENGL=$OGL DESMUME_OPENGL_CORE=$OGL # DESMUME_JIT_ARM=1
  elif [ "$ARCH" == "aarch64" ]; then
    make -C desmume/src/frontend/libretro platform=arm64-unix LDFLAGS="$LDFLAGS -lpthread" HAVE_GL=$OGL DESMUME_OPENGL=$OGL DESMUME_OPENGL_CORE=$OGL
  else
    make -C desmume/src/frontend/libretro LDFLAGS="$LDFLAGS -lpthread" HAVE_GL=$OGL DESMUME_OPENGL=$OGL DESMUME_OPENGL_CORE=$OGL
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp desmume/src/frontend/libretro/desmume_libretro.so $INSTALL/usr/lib/libretro/
}
