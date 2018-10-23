# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="rtmpdump"
PKG_VERSION="fa8646d"
PKG_SHA256="dba4d4d2e1c7de6884b01d98194b83cab6784669089fa3c919152087a3a38fd2"
PKG_LICENSE="GPL"
PKG_SITE="http://rtmpdump.mplayerhq.hu/"
PKG_URL="http://repo.or.cz/rtmpdump.git/snapshot/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="rtmpdump is a toolkit for RTMP streams."
PKG_BUILD_FLAGS="+pic -parallel"

make_target() {
  make prefix=/usr \
       incdir=/usr/include/librtmp \
       libdir=/usr/lib \
       mandir=/usr/share/man \
       CC="$CC" \
       LD="$LD" \
       AR="$AR" \
       SHARED=no \
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
       SHARED=no \
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
       SHARED=no \
       CRYPTO="OPENSSL" \
       OPT="" \
       XCFLAGS="$CFLAGS" \
       XLDFLAGS="$LDFLAGS" \
       XLIBS="-lm" \
       install
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/sbin

#  # to be removed: hack for "compatibility"
#  mkdir -p $INSTALL/usr/lib
#    ln -sf librtmp.so.1 $INSTALL/usr/lib/librtmp.so.0
}
