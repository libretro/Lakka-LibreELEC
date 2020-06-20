# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libunwind"
PKG_VERSION="1.4.0"
PKG_SHA256="df59c931bd4d7ebfd83ee481c943edf015138089b8e50abed8d9c57ba9338435"
PKG_LICENSE="GPL"
PKG_SITE="http://www.nongnu.org/libunwind/"
PKG_URL="http://download.savannah.nongnu.org/releases/libunwind/libunwind-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="library to determine the call-chain of a program"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-minidebuginfo \
                           --disable-documentation \
                           --disable-tests"

makeinstall_target() {
  make DESTDIR=$SYSROOT_PREFIX install
}
