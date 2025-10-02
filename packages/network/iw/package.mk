# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="iw"
PKG_VERSION="6.17"
PKG_SHA256="7d182e498289ab39b257da6780d562e415377107f50358ee5b55b8cfe40b1e33"
PKG_LICENSE="PUBLIC_DOMAIN"
PKG_SITE="http://wireless.kernel.org/en/users/Documentation/iw"
PKG_URL="https://www.kernel.org/pub/software/network/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libnl"
PKG_LONGDESC="A new nl80211 based CLI configuration utility for wireless devices."
# iw fails at runtime with lto enabled

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -pthread"
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/iw
    cp ${PKG_DIR}/scripts/setregdomain ${INSTALL}/usr/lib/iw
}
