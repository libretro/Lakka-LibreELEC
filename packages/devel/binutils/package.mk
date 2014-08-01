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

# binutils-2.24:
#  - fails to build with GOLD support on ARM
#    see https://sourceware.org/bugzilla/show_bug.cgi?id=15639
#    ld.gold: internal error in do_read_symbols, at build.OpenELEC-RPi.arm-devel/binutils-2.24/gold/arm.cc:6734

PKG_NAME="binutils"
PKG_VERSION="2.23.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/binutils/binutils.html"
PKG_URL="http://ftp.gnu.org/gnu/binutils/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host bison:host flex:host linux:host gmp:host mpfr:host"
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="binutils: A GNU collection of binary utilities"
PKG_LONGDESC="The GNU binutils are utilities of use when dealing with object files. the packages includes ld - the GNU linker, as - the GNU assembler, addr2line - converts addresses into filenames and line numbers, ar - a utility for creating, modifying and extracting from archives, c++filt - filter to demangle encoded C++ symbols, gprof - displays profiling information, nlmconv - converts object code into an NLM, nm - lists symbols from object files, objcopy - Copys and translates object files, objdump - displays information from object files, ranlib - generates an index to the contents of an archive, readelf - displays information from any ELF format object file, size - lists the section sizes of an object or archive file, strings - lists printable strings from files, strip - discards symbols as well as windres - a compiler for Windows resource files."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --with-sysroot=$SYSROOT_PREFIX \
                         --with-lib-path=$SYSROOT_PREFIX/lib:$SYSROOT_PREFIX/usr/lib \
                         --with-gmp=$ROOT/$TOOLCHAIN \
                         --with-mpfr=$ROOT/$TOOLCHAIN \
                         --without-ppl \
                         --without-cloog \
                         --disable-werror \
                         --disable-multilib \
                         --disable-libada \
                         --disable-libssp \
                         --enable-version-specific-runtime-libs \
                         --enable-plugins \
                         --enable-gold \
                         --enable-ld=default \
                         --enable-lto \
                         --disable-nls"

if [ "$TARGET_ARCH" = "x86_64" ]; then
  PKG_CONFIGURE_OPTS_HOST="$PKG_CONFIGURE_OPTS_HOST --enable-64-bit-bfd"
fi

pre_configure_host() {
  unset CPPFLAGS
  unset CFLAGS
  unset CXXFLAGS
  unset LDFLAGS
}

make_host() {
  make configure-host
  make
}

makeinstall_host() {
  cp -v ../include/libiberty.h $SYSROOT_PREFIX/usr/include
  make install
}
