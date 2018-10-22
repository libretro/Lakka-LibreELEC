# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libgcrypt"
PKG_VERSION="1.8.3"
PKG_SHA256="66ec90be036747602f2b48f98312361a9180c97c68a690a5f376fa0f67d0af7c"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.gnupg.org/"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/libgcrypt/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libgpg-error"
PKG_LONGDESC="A General purpose cryptographic library."
PKG_TOOLCHAIN="autotools"
# libgcrypt-1.7.x fails to build with LTO support
# see for example https://bugs.gentoo.org/show_bug.cgi?id=581114

PKG_CONFIGURE_OPTS_TARGET="CC_FOR_BUILD=$HOST_CC \
                           ac_cv_sys_symbol_underscore=no \
                           --enable-asm \
                           --with-gnu-ld \
                           --with-libgpg-error-prefix=$SYSROOT_PREFIX/usr \
                           --disable-doc"

post_makeinstall_target() {
  sed -e "s:\(['= ]\)\"/usr:\\1\"$SYSROOT_PREFIX/usr:g" -i src/$PKG_NAME-config
  cp src/$PKG_NAME-config $SYSROOT_PREFIX/usr/bin

  rm -rf $INSTALL/usr/bin
}
