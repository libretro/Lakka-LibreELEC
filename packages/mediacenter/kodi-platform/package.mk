################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="kodi-platform"
PKG_VERSION="e8574b8"
PKG_SHA256="132d5398b3bb72c6b5394ffa473c52e556419d6df8c52eb0830555dae87eb75a"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/xbmc/kodi-platform/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain tinyxml $MEDIACENTER p8-platform"
PKG_SECTION="multimedia"
PKG_SHORTDESC="kodi-platform:"
PKG_LONGDESC="kodi-platform:"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_INSTALL_LIBDIR:STRING=lib \
                       -DCMAKE_INSTALL_LIBDIR_NOARCH:STRING=lib \
                       -DCMAKE_INSTALL_PREFIX_TOOLCHAIN=$SYSROOT_PREFIX/usr \
                       -DBUILD_SHARED_LIBS=0"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/kodiplatform
}
