# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="util-macros"
PKG_VERSION="1.20.0"
PKG_SHA256="0b86b262dbe971edb4ff233bc370dfad9f241d09f078a3f6d5b7f4b8ea4430db"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/util/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="X.org autoconf utilities such as M4 macros."

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr
}
