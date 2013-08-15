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

PKG_NAME="libXVBA"
PKG_VERSION="13.8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://amd.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS="libX11"
PKG_BUILD_DEPENDS="toolchain libX11 dri2proto libXext"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libXVBA: a Video Decode library for AMD"
PKG_LONGDESC="libXVBA is a Video Decode library for AMD."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_ARCH" = i386 ]; then
  LIBXVBA_FGLRX_ARCH=x86
  LIBXVBA_LIBDIR=lib
elif [ "$TARGET_ARCH" = x86_64 ]; then
  LIBXVBA_FGLRX_ARCH=x86_64
  LIBXVBA_LIBDIR=lib64
fi

LIBXVBA_INSTALL_DIR="/usr/lib/fglrx/"

make_target() {
  : # nothing to make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include/amd
    cp include/amdxvba.h $SYSROOT_PREFIX/usr/include/amd

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp arch/$LIBXVBA_FGLRX_ARCH/usr/X11R6/*/libXvBAW.so* $SYSROOT_PREFIX/usr/lib
      ln -sf libXvBAW.so.1.0 $SYSROOT_PREFIX/usr/lib/libXvBAW.so.1
      ln -sf libXvBAW.so.1 $SYSROOT_PREFIX/usr/lib/libXvBAW.so
}

post_makeinstall_target() {
  mkdir -p $INSTALL/$LIBXVBA_INSTALL_DIR/lib
    cp arch/$LIBXVBA_FGLRX_ARCH/usr/X11R6/$LIBXVBA_LIBDIR/libAMDXvBA.cap $INSTALL/$LIBXVBA_INSTALL_DIR/lib
    cp arch/$LIBXVBA_FGLRX_ARCH/usr/X11R6/$LIBXVBA_LIBDIR/libAMDXvBA.so* $INSTALL/$LIBXVBA_INSTALL_DIR/lib/libAMDXvBA.so.1
    cp arch/$LIBXVBA_FGLRX_ARCH/usr/X11R6/$LIBXVBA_LIBDIR/libXvBAW.so* $INSTALL/$LIBXVBA_INSTALL_DIR/lib/libXvBAW.so.1

  (
    cd $INSTALL/$LIBXVBA_INSTALL_DIR/
    for lib in `find lib -type f`; do
      mkdir -p $INSTALL/usr/`dirname $lib`
        ln -sf /var/run/fglrx/$lib $INSTALL/usr/$lib
    done
  )
}
