# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="intel-ucode"
PKG_VERSION="20180807"
PKG_SHA256="29f9e8dc27e6c9b6488cecd7fe2394030307799e511db2d197d9e6553a7f9e40"
PKG_ARCH="x86_64"
PKG_LICENSE="other"
PKG_SITE="https://downloadcenter.intel.com/search?keyword=linux+microcode"
PKG_URL="https://downloadmirror.intel.com/28039/eng/microcode-${PKG_VERSION}.tgz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain intel-ucode:host"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="intel-ucode: Intel CPU microcodes"
PKG_LONGDESC="intel-ucode: Intel CPU microcodes"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p $PKG_BUILD
  tar xf $SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tgz -C $PKG_BUILD
}
