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

PKG_NAME="wayland"
PKG_VERSION="1.14.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://wayland.freedesktop.org/"
PKG_URL="http://wayland.freedesktop.org/releases/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain wayland:host libxml2"
PKG_DEPENDS_HOST="libffi:host expat:host libxml2:host"
PKG_PRIORITY="optional"
PKG_SECTION="wayland"
PKG_SHORTDESC=""
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="--enable-shared \
                         --disable-static \
                         --disable-libraries \
                         --disable-documentation \
                         --with-gnu-ld"

PKG_CONFIGURE_OPTS_TARGET="--with-sysroot=$SYSROOT_PREFIX \
                           --with-host-scanner \
                           --enable-shared \
                           --disable-static \
                           --enable-libraries \
                           --disable-documentation \
                           --with-gnu-ld"

pre_configure_target() {
  strip_lto
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share

  cp $TOOLCHAIN/lib/pkgconfig/wayland-scanner.pc $SYSROOT_PREFIX/usr/lib/pkgconfig/
}
