################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="allwinner-mali"
PKG_VERSION="3d7f4d4"
PKG_SHA256="ef5f0f2c0545d1a20d283b87aa447f452e353150cdffadc7f405559e42626cb8"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/linux-sunxi/sunxi-mali"
PKG_URL="$LAKKA_MIRROR/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="r6p2-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain libdrm wayland"
PKG_SECTION="graphics"
PKG_SHORTDESC="Allwinner Mali-400/450 support libraries"
PKG_LONGDESC="Allwinner Mali-400/450 support libraries"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
 : # nothing todo
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include/
    cp -av fbdev/include/* $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp -PRv $PKG_DIR/pkgconfig/*.pc $SYSROOT_PREFIX/usr/lib/pkgconfig

if [ "$TARGET_ARCH" == "arm" ]; then
  MALI="libwayland_for_mali/h3/lib_wayland/libMali.so"
  elif [ "$TARGET_ARCH" == "aarch64" ]; then
  MALI="libwayland_for_mali/h64/lib_wayland_h64/libMali.so"
  fi

  mkdir -p $SYSROOT_PREFIX/usr/lib/
    cp -v $MALI $SYSROOT_PREFIX/usr/lib

  mkdir -p $INSTALL/usr/lib
    cp -v $MALI $INSTALL/usr/lib

    for lib in libEGL.so \
               libEGL.so.1 \
               libEGL.so.1.4 \
               libGLESv2.so \
               libGLESv2.so.2 \
               libGLESv2.so.2.0 \
               libgbm.so \
               libgbm.so.1; do
      ln -sfv libMali.so $INSTALL/usr/lib/${lib}
      ln -sfv libMali.so $SYSROOT_PREFIX/usr/lib/${lib}
    done
}
