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

PKG_NAME="libimobiledevice"
PKG_VERSION="1.2.0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.libimobiledevice.org"
PKG_URL="http://www.libimobiledevice.org/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusbmuxd openssl"
PKG_SECTION="libs"
PKG_SHORTDESC="libimobiledevice is a cross-platform software library that talks the protocols to support iPhone®, iPod Touch®, iPad® and Apple TV® devices"
PKG_LONGDESC="libimobiledevice is a cross-platform software library that talks the protocols to support iPhone®, iPod Touch®, iPad® and Apple TV® devices"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --without-cython \
                           --disable-largefile"

post_makeinstall_target() {
  cp $PKG_BUILD/common/utils.h $SYSROOT_PREFIX/usr/include/libimobiledevice/
}
