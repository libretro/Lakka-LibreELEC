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

PKG_NAME="zlib"
PKG_VERSION="1.2.11"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.zlib.net"
PKG_URL="http://zlib.net/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_HOST=""
PKG_SECTION="compress"
PKG_SHORTDESC="zlib: A general purpose (ZIP) data compression library"
PKG_LONGDESC="zlib is a general purpose data compression library. All the code is thread safe. The data format used by the zlib library is described by RFCs (Request for Comments) 1950 to 1952 in the files ftp://ds.internic.net/rfc/rfc1950.txt (zlib format), rfc1951.txt (deflate format) and rfc1952.txt (gzip format)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_configure_target() {
 ## configure minizip
 (
  cd $ROOT/$PKG_BUILD/contrib/minizip
  rm Makefile
  export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:../../"
  do_autoreconf
  cp $ROOT/$PKG_BUILD/.$TARGET_NAME/zconf.h ./
  ./configure --host=$TARGET_NAME --build=$HOST_NAME $TARGET_CONFIGURE_OPTS --disable-shared --enable-static
 )
}

post_make_target() {
 # make minizip
 make -C $ROOT/$PKG_BUILD/contrib/minizip
}

post_makeinstall_target() {
 # Install minizip
 make -C $ROOT/$PKG_BUILD/contrib/minizip DESTDIR=$SYSROOT_PREFIX install
}

