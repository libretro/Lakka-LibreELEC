# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="icu"
PKG_VERSION="75-1"
PKG_SHA256="925e6b4b8cf8856e0ac214f6f34e30dee63b7bb7a50460ab4603950eff48f89e"
PKG_LICENSE="Custom"
PKG_SITE="https://icu.unicode.org"
PKG_URL="https://github.com/unicode-org/icu/archive/release-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain icu:host"
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
