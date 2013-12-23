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

PKG_NAME="libmicrohttpd"
PKG_VERSION="0.9.33"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.gnu.org/software/libmicrohttpd/"
PKG_URL="ftp://ftp.gnu.org/gnu/libmicrohttpd/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS="libgcrypt"
PKG_BUILD_DEPENDS_TARGET="toolchain libgcrypt"
PKG_PRIORITY="optional"
PKG_SECTION="web"
PKG_SHORTDESC="libmicrohttpd: a small webserver C library"
PKG_LONGDESC="GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-curl \
                           --disable-https \
                           --with-libgcrypt-prefix=$SYSROOT_PREFIX/usr"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
