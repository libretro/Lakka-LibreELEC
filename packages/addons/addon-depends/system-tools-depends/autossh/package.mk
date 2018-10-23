# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="autossh"
PKG_VERSION="1.4f"
PKG_SHA256="0172e5e1bea40c642e0ef025334be3aadd4ff3b4d62c0b177ed88a8384e2f8f2"
PKG_LICENSE="GPL"
PKG_SITE="http://www.harding.motd.ca/"
PKG_URL="http://www.harding.motd.ca/autossh/autossh-${PKG_VERSION}.tgz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Automatically restart SSH sessions and tunnels."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"

pre_configure_target() {
  export CFLAGS="$CFLAGS -I."
}

makeinstall_target() {
  :
}
