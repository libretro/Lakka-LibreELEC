# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rtmpdump"
PKG_VERSION="f1b83c10d8beb43fcc70a6e88cf4325499f25857"
PKG_SHA256="c68e05989a93c002e3ba8df3baef0021c17099aa2123a9c096a5cc8e029caf95"
PKG_LICENSE="GPL"
PKG_SITE="http://rtmpdump.mplayerhq.hu/"
PKG_URL="http://repo.or.cz/rtmpdump.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="rtmpdump is a toolkit for RTMP streams."
PKG_BUILD_FLAGS="+pic"

make_target() {
  make prefix=/usr \
       incdir=/usr/include/librtmp \
       libdir=/usr/lib \
       mandir=/usr/share/man \
       CC="${CC}" \
       LD="${LD}" \
       AR="${AR}" \
       SHARED=no \
       CRYPTO="OPENSSL" \
       OPT="" \
       XCFLAGS="${CFLAGS}" \
       XCFLAGS="${CFLAGS} -Wno-unused-but-set-variable -Wno-unused-const-variable" \
       XLDFLAGS="${LDFLAGS}" \
       XLIBS="-lm"
}

makeinstall_target() {
  make DESTDIR=${SYSROOT_PREFIX} \
       prefix=/usr \
       incdir=/usr/include/librtmp \
       libdir=/usr/lib \
       mandir=/usr/share/man \
       CC="${CC}" \
       LD="${LD}" \
       AR="${AR}" \
       SHARED=no \
       CRYPTO="OPENSSL" \
       OPT="" \
       XCFLAGS="${CFLAGS}" \
       XLDFLAGS="${LDFLAGS}" \
       XLIBS="-lm" \
       install

  make DESTDIR=${INSTALL} \
       prefix=/usr \
       incdir=/usr/include/librtmp \
       libdir=/usr/lib \
       mandir=/usr/share/man \
       CC="${CC}" \
       LD="${LD}" \
       AR="${AR}" \
       SHARED=no \
       CRYPTO="OPENSSL" \
       OPT="" \
       XCFLAGS="${CFLAGS}" \
       XLDFLAGS="${LDFLAGS}" \
       XLIBS="-lm" \
       install
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/sbin

#  # to be removed: hack for "compatibility"
#  mkdir -p ${INSTALL}/usr/lib
#    ln -sf librtmp.so.1 ${INSTALL}/usr/lib/librtmp.so.0
}
