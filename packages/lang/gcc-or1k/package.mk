# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-or1k"
PKG_VERSION="11.3.0"
PKG_SHA256="b47cf2818691f5b1e21df2bb38c795fac2cfbd640ede2d0a5e1c89e338a3ac39"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="http://gcc.gnu.org/"
PKG_URL="http://ftpmirror.gnu.org/gcc/gcc-${PKG_VERSION}/gcc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="toolchain:host ccache:host autoconf:host binutils-or1k:host gmp:host mpfr:host mpc:host zstd:host"
PKG_LONGDESC="This package contains the GNU Compiler Collection for OpenRISC 1000."

PKG_CONFIGURE_OPTS_HOST="--target=or1k-none-elf \
                         --with-sysroot=${SYSROOT_PREFIX} \
                         --with-gmp=${TOOLCHAIN} \
                         --with-mpfr=${TOOLCHAIN} \
                         --with-mpc=${TOOLCHAIN} \
                         --with-zstd=${TOOLCHAIN} \
                         --with-gnu-as \
                         --with-gnu-ld \
                         --with-newlib \
                         --without-ppl \
                         --without-headers \
                         --without-cloog \
                         --enable-__cxa_atexit \
                         --enable-checking=release \
                         --enable-gold \
                         --enable-languages=c \
                         --enable-ld=default \
                         --enable-lto \
                         --enable-plugin \
                         --enable-static \
                         --disable-decimal-float \
                         --disable-gcov \
                         --disable-libada \
                         --disable-libatomic \
                         --disable-libgomp \
                         --disable-libitm \
                         --disable-libmpx \
                         --disable-libmudflap \
                         --disable-libquadmath \
                         --disable-libquadmath-support \
                         --disable-libsanitizer \
                         --disable-libssp \
                         --disable-multilib \
                         --disable-nls \
                         --disable-shared \
                         --disable-threads"

post_makeinstall_host() {
  PKG_GCC_PREFIX="${TOOLCHAIN}/bin/or1k-none-elf-"
  GCC_VERSION=$(${PKG_GCC_PREFIX}gcc -dumpversion)
  DATE="0501$(echo ${GCC_VERSION} | sed 's/\./0/g')"
  CROSS_CC=${PKG_GCC_PREFIX}gcc-${GCC_VERSION}

  rm -f ${PKG_GCC_PREFIX}gcc

cat > ${PKG_GCC_PREFIX}gcc <<EOF
#!/bin/sh
${TOOLCHAIN}/bin/ccache ${CROSS_CC} "\$@"
EOF

  chmod +x ${PKG_GCC_PREFIX}gcc

  # To avoid cache trashing
  touch -c -t ${DATE} ${CROSS_CC}
}
