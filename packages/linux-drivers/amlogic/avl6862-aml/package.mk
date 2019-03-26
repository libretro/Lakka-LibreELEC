# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="avl6862-aml"
PKG_VERSION="1.0"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_LONGDESC="avl6862-aml: Internal DVB tuner driver for Amlogic devices developed by afl1"

post_install() {
  enable_service amlogic-dvb.service
}
