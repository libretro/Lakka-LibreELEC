# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pcre2"
PKG_VERSION="10.36"
PKG_SHA256="a9ef39278113542968c7c73a31cfcb81aca1faa64690f400b907e8ab6b4a665c"
PKG_LICENSE="BSD"
PKG_SITE="http://www.pcre.org/"
PKG_URL="${SOURCEFORGE_SRC}/pcre/${PKG_NAME}/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A set of functions that implement regular expression pattern matching using the same syntax."
PKG_TOOLCHAIN="cmake"
PKG_BUILD_FLAGS="+pic"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DPCRE2_BUILD_PCRE2_16=ON \
                       -DPCRE2_SUPPORT_LIBREADLINE=OFF"

post_makeinstall_target() {
  safe_remove ${INSTALL}/usr/bin
}
