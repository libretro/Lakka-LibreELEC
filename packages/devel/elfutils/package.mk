# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="elfutils"
PKG_VERSION="0.170"
PKG_SHA256="1f844775576b79bdc9f9c717a50058d08620323c1e935458223a12f249c9e066"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://sourceware.org/elfutils/"
PKG_URL="https://sourceware.org/elfutils/ftp/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="make:host zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_SECTION="devel"
PKG_SHORTDESC="elfutils: collection of utilities to handle ELF objects"
PKG_LONGDESC="Elfutils is a collection of utilities, including eu-ld (a linker), eu-nm (for listing symbols from object files), eu-size (for listing the section sizes of an object or archive file), eu-strip (for discarding symbols), eu-readelf (to see the raw ELF file structures), and eu-elflint (to check for well-formed ELF files)."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="utrace_cv_cc_biarch=false \
                           --disable-nls \
                           --with-zlib \
                           --without-bzlib \
                           --without-lzma"

PKG_CONFIGURE_OPTS_HOST="utrace_cv_cc_biarch=false \
                           --disable-nls \
                           --with-zlib \
                           --without-bzlib \
                           --without-lzma"

makeinstall_host() {
  make DESTDIR="$INSTALL" -C libelf install
}

make_target() {
  make V=1 -C libelf libelf.a
  make V=1 -C libebl libebl.a
  make V=1 -C libdwfl libdwfl.a
  make V=1 -C libdwelf libdwelf.a
  make V=1 -C libdw libdw.a
}

makeinstall_target() {
  make DESTDIR="$SYSROOT_PREFIX" -C libelf install-includeHEADERS install-pkgincludeHEADERS
  make DESTDIR="$SYSROOT_PREFIX" -C libdwfl install-pkgincludeHEADERS
  make DESTDIR="$SYSROOT_PREFIX" -C libdw install-includeHEADERS install-pkgincludeHEADERS

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp libelf/libelf.a $SYSROOT_PREFIX/usr/lib
    cp libebl/libebl.a $SYSROOT_PREFIX/usr/lib
    cp libdwfl/libdwfl.a $SYSROOT_PREFIX/usr/lib
    cp libdw/libdw.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/include/elfutils
    cp version.h $SYSROOT_PREFIX/usr/include/elfutils
}
