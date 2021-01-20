# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fribidi"
PKG_VERSION="1.0.10"
PKG_SHA256="7f1c687c7831499bcacae5e8675945a39bacbad16ecaa945e9454a32df653c01"
PKG_LICENSE="LGPL"
PKG_SITE="http://fribidi.freedesktop.org/"
PKG_URL="https://github.com/fribidi/fribidi/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A bidirectional algorithm library."
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="+pic"

PKG_MESON_OPTS_TARGET="-Ddeprecated=false \
                       -Ddocs=false \
                       -Ddefault_library=static"

post_makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/bin
    cp -f ${PKG_DIR}/scripts/fribidi-config ${SYSROOT_PREFIX}/usr/bin
    chmod +x ${SYSROOT_PREFIX}/usr/bin/fribidi-config

  rm -rf ${INSTALL}/usr/bin
}
