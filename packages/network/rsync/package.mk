# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rsync"
PKG_VERSION="3.2.4"
PKG_SHA256="6f761838d08052b0b6579cf7f6737d93e47f01f4da04c5d24d3447b7f2a5fad1"
PKG_LICENSE="GPLv3"
PKG_SITE="https://rsync.samba.org"
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
