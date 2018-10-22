# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdnet"
PKG_VERSION="8029bf9"
PKG_SHA256="1e41cbe5e4884108b08fa92964305354f1662b7e889f62736b3749845d7a8c56"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/sgeto/libdnet"
PKG_URL="https://github.com/sgeto/libdnet/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A simplified, portable interface to several low-level networking routines"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_strlcat=no \
                           ac_cv_func_strlcpy=no \
                           --enable-static \
                           --disable-shared \
                           --disable-python"

pre_configure_target() {
  export CFLAGS+=" -I$PKG_BUILD/include"
}

post_makeinstall_target() {
  cp $SYSROOT_PREFIX/usr/bin/dnet-config \
     $TOOLCHAIN/bin/dnet-config
}
