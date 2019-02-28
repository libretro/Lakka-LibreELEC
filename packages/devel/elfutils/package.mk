# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="elfutils"
PKG_VERSION="0.176"
PKG_SHA256="eb5747c371b0af0f71e86215a5ebb88728533c3a104a43d4231963f308cd1023"
PKG_LICENSE="GPL"
PKG_SITE="https://sourceware.org/elfutils/"
PKG_URL="https://sourceware.org/elfutils/ftp/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="make:host zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib elfutils:host"
PKG_LONGDESC="A collection of utilities to handle ELF objects."
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
