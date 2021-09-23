# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rsync"
PKG_VERSION="3.2.3"
PKG_SHA256="becc3c504ceea499f4167a260040ccf4d9f2ef9499ad5683c179a697146ce50e"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.samba.org/ftp/rsync/rsync.html"
PKG_URL="https://download.samba.org/pub/rsync/src/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="autotools:host zlib:host zstd:host"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="A very fast method for bringing remote files into sync."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_HOST="--with-included-popt \
                         --without-included-zlib \
                         --disable-openssl \
                         --disable-lz4 \
                         --enable-zstd \
                         --disable-xxhash"

PKG_CONFIGURE_OPTS_TARGET="--disable-acl-support \
                           --disable-asm \
                           --enable-openssl \
                           --disable-lz4 \
                           --disable-md2man \
                           --disable-simd \
                           --disable-xattr-support \
                           --disable-xxhash \
                           --disable-zstd \
                           --with-included-popt \
                           --without-included-zlib"

pre_make_host() {
  # do not detect LE git version
  echo "#define RSYNC_GITVER \"${PKG_VERSION}\"" >git-version.h
}

pre_make_target() {
  pre_make_host
}
