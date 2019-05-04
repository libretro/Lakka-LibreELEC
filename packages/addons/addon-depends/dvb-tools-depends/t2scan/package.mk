# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="t2scan"
PKG_VERSION="8b9ad91e8685ff80e7c5d924caec83f1ee49ebf3"
PKG_SHA256="cdfae6232ba1bbc954bd228f9db217d004c07407cf46245816d39f4599e91111"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/mighty-p/t2scan"
PKG_URL="https://github.com/mighty-p/t2scan/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A small channel scan tool which generates DVB-T/T2 channels.conf files."

makeinstall_target() {
  :
}
