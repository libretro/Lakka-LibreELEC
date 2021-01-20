# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="enet"
PKG_VERSION="d9e561938fd9360cdbbd67d78b105ccbe4af0a65" # 10 Jan 2021 # 1.3.17+vita
PKG_SHA256="ff52ea54edb71662d5933b165c073f079c90ed9adcf98bcb7b2e74d4ddf3dc6b"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/cgutman/enet/"
PKG_URL="https://github.com/cgutman/enet/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A network communication layer on top of UDP (User Datagram Protocol)."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"

post_makeinstall_target() {
  rm -r ${INSTALL}
}
