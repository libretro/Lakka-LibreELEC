# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="intel-ucode"
PKG_VERSION="20180807a"
PKG_SHA256="46ab18699ec42eb6cc01ee1846ec4d7ca979766dee2156f92d69e2f6df548137"
PKG_ARCH="x86_64"
PKG_LICENSE="other"
PKG_SITE="https://downloadcenter.intel.com/search?keyword=linux+microcode"
PKG_URL="https://downloadmirror.intel.com/28087/eng/microcode-${PKG_VERSION}.tgz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain intel-ucode:host"
PKG_LONGDESC="intel-ucode: Intel CPU microcodes"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p $PKG_BUILD
  tar xf $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tgz -C $PKG_BUILD
}
