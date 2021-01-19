# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="autoconf-archive"
PKG_VERSION="2019.01.06"
PKG_SHA256="17195c833098da79de5778ee90948f4c5d90ed1a0cf8391b4ab348e2ec511e3f"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/autoconf-archive/"
PKG_URL="http://ftpmirror.gnu.org/autoconf-archive/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="autoconf-archive is an package of m4 macros"

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} --prefix=${TOOLCHAIN}"

makeinstall_host() {
# make install
  make prefix=${SYSROOT_PREFIX}/usr install

# remove problematic m4 file
  rm -rf ${SYSROOT_PREFIX}/usr/share/aclocal/ax_prog_cc_for_build.m4
}
