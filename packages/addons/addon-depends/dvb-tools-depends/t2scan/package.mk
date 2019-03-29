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

# aml 3.14 hack
pre_configure_target() {
  if [ "$LINUX" = "amlogic-3.14" -o "$LINUX" = "amlogic-3.10" ]; then
    sed -i 's/DVB_HEADER=0/DVB_HEADER=1/g' $PKG_BUILD/configure*
    sed -i 's/HAS_DVB_API5=0/HAS_DVB_API5=1/g' $PKG_BUILD/configure*
  fi
}

makeinstall_target() {
  :
}
