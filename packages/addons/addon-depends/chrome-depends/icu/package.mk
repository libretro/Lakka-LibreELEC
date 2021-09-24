# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="icu"
PKG_VERSION="68.1"
PKG_SHA256="a9f2e3d8b4434b8e53878b4308bd1e6ee51c9c7042e2b1a376abefb6fbb29f2d"
PKG_LICENSE="Custom"
PKG_SITE="http://www.icu-project.org"
PKG_URL="https://github.com/unicode-org/icu/releases/download/release-${PKG_VERSION//./-}/icu4c-${PKG_VERSION//./_}-src.tgz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain icu:host"
PKG_LONGDESC="International Components for Unicode library."

PKG_ICU_OPTS="--disable-extras \
              --disable-icuio \
              --disable-layoutex \
              --disable-renaming \
              --disable-samples \
              --disable-tests"

PKG_CONFIGURE_OPTS_HOST="$PKG_ICU_OPTS"

configure_package() {
  PKG_CONFIGURE_OPTS_TARGET="--disable-tools
                             --with-cross-build=$PKG_BUILD/.$HOST_NAME \
                             $PKG_ICU_OPTS"

  PKG_CONFIGURE_SCRIPT="${PKG_BUILD}/source/configure"
}
