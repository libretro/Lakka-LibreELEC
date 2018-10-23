# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libgpg-error"
PKG_VERSION="1.27"
PKG_SHA256="4f93aac6fecb7da2b92871bb9ee33032be6a87b174f54abf8ddf0911a22d29d2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://www.gnupg.org"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/libgpg-error/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A library that defines common error values for all GnuPG components."

PKG_CONFIGURE_OPTS_TARGET="CC_FOR_BUILD=$HOST_CC --enable-static --disable-shared --disable-nls --disable-rpath --with-gnu-ld --with-pic"

pre_configure_target() {
# inspired by openembedded
  case ${TARGET_ARCH} in
    aarch64)
      GPGERROR_TUPLE=aarch64-unknown-linux-gnu
      GPGERROR_TARGET=linux-gnueabi
      ;;
    arm)
      GPGERROR_TUPLE=arm-unknown-linux-gnueabi
      GPGERROR_TARGET=linux-gnueabi
      ;;
    i386)
      GPGERROR_TUPLE=i486-pc-linux-gnu
      GPGERROR_TARGET=linux-gnu
      ;;
    x86_64)
      GPGERROR_TUPLE=x86_64-pc-linux-gnu
      GPGERROR_TARGET=linux-gnu
      ;;
  esac

  cp $PKG_BUILD/src/syscfg/lock-obj-pub.$GPGERROR_TUPLE.h $PKG_BUILD/src/syscfg/lock-obj-pub.$GPGERROR_TARGET.h
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/share

  sed -e "s:\(['= ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" -i src/gpg-error-config
  cp src/gpg-error-config $SYSROOT_PREFIX/usr/bin
}
