# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="icu"
PKG_VERSION="68.2"
PKG_SHA256="f790b0202facbbf19c5581a7a5f21b2b4b6ed70ba3e4bef8d5560868e5e82476"
PKG_LICENSE="Custom"
PKG_SITE="http://www.icu-project.org"
PKG_URL="https://github.com/unicode-org/icu/archive/release-${PKG_VERSION//./-}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain icu:host"
PKG_LONGDESC="International Components for Unicode library."
PKG_TOOLCHAIN="configure"

PKG_BUILD_FLAGS="-sysroot"

configure_package() {
  PKG_CONFIGURE_SCRIPT="${PKG_BUILD}/icu4c/source/configure"
  PKG_CONFIGURE_OPTS_TARGET="--disable-layout \
                             --disable-layoutex \
                             --enable-renaming \
                             --disable-samples \
                             --disable-tests \
                             --disable-tools \
                             --with-cross-build=${PKG_BUILD}/.${HOST_NAME}"
}
