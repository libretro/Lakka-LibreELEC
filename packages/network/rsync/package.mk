# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rsync"
PKG_VERSION="3.2.5"
PKG_SHA256="2ac4d21635cdf791867bc377c35ca6dda7f50d919a58be45057fd51600c69aba"
PKG_LICENSE="GPLv3"
PKG_SITE="https://rsync.samba.org"
PKG_URL="https://download.samba.org/pub/rsync/src/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="autotools:host zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib openssl"
PKG_LONGDESC="A very fast method for bringing remote files into sync."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_HOST="--disable-md2man \
                         --disable-ipv6 \
                         --disable-openssl \
                         --disable-xxhash \
                         --disable-zstd \
                         --disable-lz4 \
                         --disable-iconv \
                         --with-included-popt \
                         --without-included-zlib"

PKG_CONFIGURE_OPTS_TARGET="--disable-acl-support \
                           --disable-md5-asm \
                           --enable-openssl \
                           --disable-lz4 \
                           --disable-md2man \
                           --disable-roll-simd \
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
