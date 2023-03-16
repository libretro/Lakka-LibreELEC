# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="font-bitstream-type1"
PKG_VERSION="1.0.4"
PKG_SHA256="de2f238b4cd72db4228a0ba67829d76a2b7c039e22993d66a722ee385248c628"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/font/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros font-xfree86-type1"
PKG_LONGDESC="Bitstream font family."

PKG_CONFIGURE_OPTS_TARGET="--with-fontrootdir=/usr/share/fonts"

post_install() {
  mkfontdir ${INSTALL}/usr/share/fonts/Type1
  mkfontscale ${INSTALL}/usr/share/fonts/Type1
}
