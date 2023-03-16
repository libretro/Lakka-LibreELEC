# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="font-cursor-misc"
PKG_VERSION="1.0.4"
PKG_SHA256="25d9c9595013cb8ca08420509993a6434c917e53ca1fec3f63acd45a19d4f982"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/font/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros font-util:host"
PKG_LONGDESC="X11 cursor fonts."

PKG_CONFIGURE_OPTS_TARGET="--with-fontrootdir=/usr/share/fonts"

post_install() {
  mkfontdir ${INSTALL}/usr/share/fonts/misc
  mkfontscale ${INSTALL}/usr/share/fonts/misc
}
