# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="liberation-fonts-ttf"
PKG_VERSION="2.1.2"
PKG_SHA256="14694930f28391675008c67b18889d1a7dfea74b16adf50394f8057b57eaf8e0"
PKG_LICENSE="OFL1_1"
PKG_SITE="https://github.com/liberationfonts/liberation-fonts"
PKG_URL="https://github.com/liberationfonts/liberation-fonts/files/5722233/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_LONGDESC="This packages included the high-quality and open-sourced TrueType vector fonts."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/fonts/liberation
    cp *.ttf ${INSTALL}/usr/share/fonts/liberation
}

post_install() {
  mkfontdir ${INSTALL}/usr/share/fonts/liberation
  mkfontscale ${INSTALL}/usr/share/fonts/liberation
}
