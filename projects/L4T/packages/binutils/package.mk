# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="binutils"
PKG_VERSION="2.32"
PKG_SHA256="0ab6c55dd86a92ed561972ba15b9b70a8b9f75557f896446c82e8b36e473ee04"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/binutils/"
PKG_URL="http://ftp.gnu.org/gnu/binutils/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host bison:host flex:host linux:host"
PKG_DEPENDS_TARGET="toolchain zlib binutils:host"
PKG_LONGDESC="A GNU collection of binary utilities."

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} \
                         --with-sysroot=${SYSROOT_PREFIX} \
                         --with-lib-path=${SYSROOT_PREFIX}/lib:${SYSROOT_PREFIX}/usr/lib \
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

PKG_CONFIGURE_OPTS_TARGET="--target=${TARGET_NAME} \
                         --with-sysroot=${SYSROOT_PREFIX} \
                         --with-lib-path=${SYSROOT_PREFIX}/lib:${SYSROOT_PREFIX}/usr/lib \
                         --with-system-zlib \
                         --without-ppl \
                         --without-cloog \
                         --enable-static \
                         --enable-shared \
                         --disable-werror \
                         --disable-multilib \
                         --disable-libada \
                         --disable-libssp \
                         --disable-plugins \
                         --disable-gold \
                         --disable-ld \
                         --disable-lto \
                         --disable-nls"

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
  cp -v ../include/libiberty.h ${SYSROOT_PREFIX}/usr/include
  make install
}

make_target() {
  make configure-host
  make -C libiberty
  make -C bfd
  make -C opcodes
  make -C binutils strings
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib
    cp libiberty/libiberty.a ${SYSROOT_PREFIX}/usr/lib
  make DESTDIR="${SYSROOT_PREFIX}" -C bfd install
  make DESTDIR="${SYSROOT_PREFIX}" -C opcodes install

  mkdir -p ${INSTALL}/usr/bin
    cp binutils/strings ${INSTALL}/usr/bin
}
