# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="procps-ng"
PKG_VERSION="3.3.15"
PKG_SHA256="191391fde24a1d3b9b0030d26f8dfdcbf641d36297aab7ecf2f941c5ca927e21"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.com/procps-ng/procps"
PKG_URL="https://gitlab.com/procps-ng/procps/-/archive/v${PKG_VERSION}/procps-v${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="Command line and full screen utilities for browsing procfs."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes \
                           --disable-shared \
                           --disable-modern-top \
                           --enable-static"

PKG_MAKE_OPTS_TARGET="free top/top proc/libprocps.la proc/libprocps.pc"

PKG_MAKEINSTALL_OPTS_TARGET="install-libLTLIBRARIES install-pkgconfigDATA"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_BUILD/.$TARGET_NAME/free $INSTALL/usr/bin
    cp -P $PKG_BUILD/.$TARGET_NAME/top/top $INSTALL/usr/bin

  make DESTDIR=$SYSROOT_PREFIX -j1 $PKG_MAKEINSTALL_OPTS_TARGET
}
