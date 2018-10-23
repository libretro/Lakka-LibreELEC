# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="v86d"
PKG_VERSION="0.1.10"
PKG_SHA256="634964ae18ef68c8493add2ce150e3b4502badeb0d9194b4bd81241d25e6735c"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://dev.gentoo.org/~spock/projects/uvesafb/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_INIT="toolchain gcc:init"
PKG_LONGDESC="v86d is the userspace helper that runs x86 code in an emulated environment."

INIT_CONFIGURE_OPTS="--with-x86emu"

pre_configure_init() {
# v86d fails to build in subdirs
  cd $PKG_BUILD
    rm -rf .$TARGET_NAME-init
}

makeinstall_init() {
  DESTDIR=$INSTALL/usr make install
}
