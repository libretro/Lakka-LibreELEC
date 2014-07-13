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

PKG_NAME="rtmpdump"
PKG_VERSION="e0056c5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://rtmpdump.mplayerhq.hu/"
#PKG_URL="http://rtmpdump.mplayerhq.hu/download/$PKG_NAME-$PKG_VERSION.tgz"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib libressl"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="rtmpdump: a toolkit for RTMP streams."
PKG_LONGDESC="rtmpdump is a toolkit for RTMP streams. All forms of RTMP are supported, including rtmp://, rtmpt://, rtmpe://, rtmpte://, and rtmps://."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

MAKEFLAGS="-j1"

make_target() {
  make prefix=/usr \
       incdir=/usr/include/librtmp \
       libdir=/usr/lib \
       mandir=/usr/share/man \
       CC="$CC" \
       LD="$LD" \
       AR="$AR" \
       CRYPTO="OPENSSL" \
       OPT="" \
       XCFLAGS="$CFLAGS" \
       XLDFLAGS="$LDFLAGS" \
       XLIBS="-lm"
}

makeinstall_target() {
  make DESTDIR=$SYSROOT_PREFIX \
       prefix=/usr \
       incdir=/usr/include/librtmp \
       libdir=/usr/lib \
       mandir=/usr/share/man \
       CC="$CC" \
       LD="$LD" \
       AR="$AR" \
       CRYPTO="OPENSSL" \
       OPT="" \
       XCFLAGS="$CFLAGS" \
       XLDFLAGS="$LDFLAGS" \
       XLIBS="-lm" \
       install

  make DESTDIR=$INSTALL \
       prefix=/usr \
       incdir=/usr/include/librtmp \
       libdir=/usr/lib \
       mandir=/usr/share/man \
       CC="$CC" \
       LD="$LD" \
       AR="$AR" \
       CRYPTO="OPENSSL" \
       OPT="" \
       XCFLAGS="$CFLAGS" \
       XLDFLAGS="$LDFLAGS" \
       XLIBS="-lm" \
       install
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/sbin
}
