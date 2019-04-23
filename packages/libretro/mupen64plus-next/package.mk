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

PKG_NAME="mupen64plus-next"
PKG_VERSION="206d0f1"
PKG_GIT_BRANCH="GLideN64"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mupen64plus-libretro-nx"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain nasm:host"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Improved mupen64plus libretro core reimplementation"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  strip_lto
}

make_target() {
  case $PROJECT in
    RPi|Gamegirl|Slice)
      CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
	              -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      make platform=rpi GLES=1 FORCE_GLES=1 WITH_DYNAREC=arm
      ;;
    RPi2|Slice3)
      CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      make platform=rpi2 GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    imx6)
      CFLAGS="$CFLAGS -DLINUX -DEGL_API_FB"
      CPPFLAGS="$CPPFLAGS -DLINUX -DEGL_API_FB"
      make platform=unix GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    Generic)
      make
      ;;
    OdroidC1)
      make platform=odroid BOARD=ODROID-C1 GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    OdroidXU3)
      make platform=odroid BOARD=ODROID-XU3 GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    ROCK960)
      make platform=unix-gles GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=arm
      ;;
    *)
      if [ "$OPENGLES_SUPPORT" = "yes" ]; then
        make platform=unix-gles GLES=1 FORCE_GLES=1 HAVE_NEON=1 WITH_DYNAREC=$ARCH
      else
        make platform=unix WITH_DYNAREC=$ARCH
      fi
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mupen64plus_next_libretro.so $INSTALL/usr/lib/libretro/
}
