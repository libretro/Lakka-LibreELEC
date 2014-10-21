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

PKG_NAME="kodi-audioencoder-vorbis"
PKG_VERSION="a73ef7e"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libogg libvorbis kodi"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="kodi-audioencoder-vorbis: A audioencoder addon for Kodi"
PKG_LONGDESC="kodi-audioencoder-vorbis is a audioencoder addon for Kodi"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_MODULE_PATH=$SYSROOT_PREFIX/usr/lib/kodi \
        -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr \
        -DOGG_INCLUDE_DIRS=$SYSROOT_PREFIX/usr/include \
        -DVORBIS_INCLUDE_DIRS=$SYSROOT_PREFIX/usr/include \
        -DVORBISENC_INCLUDE_DIRS=$SYSROOT_PREFIX/usr/include \
        ..
}
