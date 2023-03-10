# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libtool"
PKG_VERSION="2.4.7"
PKG_SHA256="04e96c2404ea70c590c546eba4202a4e12722c640016c12b9b2f1ce3d481e9a8"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/libtool/"
PKG_URL="http://ftpmirror.gnu.org/libtool/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host autoconf:host automake:host intltool:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A generic library support script."

PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared"

post_unpack() {
  chmod u+w ${PKG_BUILD}/build-aux/ltmain.sh
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/share
}
