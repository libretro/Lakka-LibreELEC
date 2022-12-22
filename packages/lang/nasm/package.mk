# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="nasm"
PKG_VERSION="2.16.01"
PKG_SHA256="c77745f4802375efeee2ec5c0ad6b7f037ea9c87c92b149a9637ff099f162558"
PKG_ARCH="x86_64"
PKG_LICENSE="BSD"
PKG_SITE="https://www.nasm.us/"
PKG_URL="https://www.nasm.us/pub/nasm/releasebuilds/${PKG_VERSION}/nasm-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="The Netwide Assembler, NASM, is an 80x86 and x86-64 assembler designed for portability and modularity."

pre_configure_host() {
  HOST_CONFIGURE_OPTS=$(echo ${HOST_CONFIGURE_OPTS} | sed -e "s|--disable-static||" -e "s|--enable-shared||")
}
