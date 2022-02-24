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

PKG_NAME="citra"
PKG_VERSION="50b8e1e"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/libretro/citra"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="A Nintendo 3DS Emulator"
PKG_LONGDESC="A Nintendo 3DS Emulator"
PKG_TOOLCHAIN="make"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="\
                      HAVE_FFMPEG_STATIC=1 \
                      FFMPEG_DISABLE_VDPAU=1 \
                      HAVE_FFMPEG_CROSSCOMPILE=1"

if [ "$OPENGL_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

pre_make_target() {
  cd $PKG_BUILD
  PKG_MAKE_OPTS_TARGET+="\
                         FFMPEG_XC_CPU=$TARGET_CPU \
                         FFMPEG_XC_ARCH=$TARGET_ARCH \
                         FFMPEG_XC_PREFIX=$TARGET_PREFIX \
                         FFMPEG_XC_SYSROOT=$SYSROOT_PREFIX \
                         FFMPEG_XC_NM=$NM \
                         FFMPEG_XC_AR=$AR \
                         FFMPEG_XC_AS=$CC \
                         FFMPEG_XC_CC=$CC \
                         FFMPEG_XC_LD=$CC"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp citra_libretro.so $INSTALL/usr/lib/libretro/
}
