# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="icu"
PKG_VERSION="61.1"
PKG_SHA256="d007f89ae8a2543a53525c74359b65b36412fa84b3349f1400be6dcf409fafef"
PKG_LICENSE="Custom"
PKG_SITE="http://www.icu-project.org"
PKG_URL="http://download.icu-project.org/files/icu4c/${PKG_VERSION}/icu4c-${PKG_VERSION//./_}-src.tgz"
PKG_DEPENDS_TARGET="toolchain icu:host"
PKG_LONGDESC="International Components for Unicode library."

PKG_ICU_OPTS="--disable-extras \
              --disable-icuio \
              --disable-layout \
              --disable-renaming \
              --disable-samples \
              --disable-tests \
              --disable-tools"


PKG_CONFIGURE_OPTS_HOST="--enable-static \
                         --disable-shared \
                         $PKG_ICU_OPTS"

PKG_CONFIGURE_OPTS_TARGET="--with-cross-build=$PKG_BUILD/.$HOST_NAME \
                         $PKG_ICU_OPTS"

PKG_CONFIGURE_SCRIPT="source/configure"

post_makeinstall_target() {
  rm -rf $INSTALL
}
