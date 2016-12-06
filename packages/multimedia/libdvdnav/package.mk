################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
#      Copyright (C) 2009-2016 Team LibreELEC (team@libreelec.tv)
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

PKG_NAME="libdvdnav"
PKG_VERSION="43b5f81"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/libdvdnav"
PKG_URL="https://github.com/xbmc/libdvdnav/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libdvdread"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libdvdnav: a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games."
PKG_LONGDESC="libdvdnav is a library that allows easy use of sophisticated DVD navigation features such as DVD menus, multiangle playback and even interactive DVD games."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-pic"

pre_configure_target() {
  export CFLAGS="$CFLAGS -D_XBMC -DHAVE_DVDCSS_DVDCSS_H"
}

post_makeinstall_target() {
  ln -sf dvdnav.pc $SYSROOT_PREFIX/usr/lib/pkgconfig/libdvdnav.pc
}
