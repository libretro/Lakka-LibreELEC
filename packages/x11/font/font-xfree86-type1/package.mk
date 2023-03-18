# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="font-xfree86-type1"
PKG_VERSION="1.0.5"
PKG_SHA256="a93c2c788a5ea1c002af7c8662cf9d9821fb1df51b8d2b2c5e0026dfdfea4837"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/releases/individual/font/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="A Xfree86 Inc. Type1 font."

PKG_CONFIGURE_OPTS_TARGET="--with-fontrootdir=/usr/share/fonts"

post_install() {
  mkfontdir ${INSTALL}/usr/share/fonts/Type1
  mkfontscale ${INSTALL}/usr/share/fonts/Type1
}
