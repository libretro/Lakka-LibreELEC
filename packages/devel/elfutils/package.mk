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

PKG_NAME="elfutils"
PKG_VERSION="0.167"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://sourceware.org/elfutils/"
PKG_URL="https://sourceware.org/elfutils/ftp/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_SECTION="devel"
PKG_SHORTDESC="elfutils: collection of utilities to handle ELF objects"
PKG_LONGDESC="Elfutils is a collection of utilities, including eu-ld (a linker), eu-nm (for listing symbols from object files), eu-size (for listing the section sizes of an object or archive file), eu-strip (for discarding symbols), eu-readelf (to see the raw ELF file structures), and eu-elflint (to check for well-formed ELF files)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="utrace_cv_cc_biarch=false \
                           --disable-werror \
                           --disable-progs \
                           --disable-nls \
                           --with-zlib \
                           --without-bzlib \
                           --without-lzma"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC -DPIC"
}

make_target() {
  make V=1 -C libelf libelf.a
  make V=1 -C libebl libebl.a
  make V=1 -C libdwfl libdwfl.a
  make V=1 -C libdw libdw.a
}

makeinstall_target() {
  make DESTDIR="$SYSROOT_PREFIX" -C libelf install-includeHEADERS install-pkgincludeHEADERS
  make DESTDIR="$SYSROOT_PREFIX" -C libdw install-includeHEADERS install-pkgincludeHEADERS

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp libelf/libelf.a $SYSROOT_PREFIX/usr/lib
    cp libdw/libdw.a $SYSROOT_PREFIX/usr/lib
}
