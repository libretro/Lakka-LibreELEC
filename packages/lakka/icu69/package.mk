# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="icu69"
PKG_VERSION="69.1"
PKG_SHA256="39ce83dd5d15c7539dde261733e106a391923f82caf1ce52ecaebb72d93b4579"
PKG_LICENSE="Custom"
PKG_SITE="http://www.icu-project.org"
PKG_URL="https://github.com/unicode-org/icu/archive/release-${PKG_VERSION//./-}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain icu69:host"
PKG_LONGDESC="International Components for Unicode library."
PKG_TOOLCHAIN="configure"

PKG_BUILD_FLAGS="-sysroot"

if [ "${DISTRO}" = "Lakka" ]; then
  PKG_BUILD_FLAGS=""
fi

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
