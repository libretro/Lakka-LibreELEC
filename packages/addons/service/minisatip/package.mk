# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minisatip"
PKG_VERSION="1.1.92"
PKG_SHA256="b3d153473d16d8cb9b6abee5a020aac2a2d8c8a42c818cb44addfa494739d2d6"
PKG_REV="110"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/catalinii/minisatip"
PKG_URL="https://github.com/catalinii/minisatip/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain dvb-apps libdvbcsa libxml2 openssl"
PKG_SECTION="service"
PKG_SHORTDESC="minisatip: a Sat>IP streaming server for Linux"
PKG_LONGDESC="minisatip(${PKG_VERSION_NUMBER}): is a Sat>IP streaming server for Linux supporting DVB-C, DVB-S/S2, DVB-T/T2, ATSC and ISDB-T"
PKG_BUILD_FLAGS="-sysroot"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Minisatip"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-netcv \
                           --enable-dvbca \
                           --enable-dvbaes \
                           --enable-dvbcsa \
                           --with-xml2=$(get_install_dir libxml2)/usr/include/libxml2"

pre_configure_target() {
  cd ${PKG_BUILD}
    rm -rf .${TARGET_NAME}

  # enables Common Interface (DVBEN50221)
  CFLAGS+=" -I$(get_install_dir dvb-apps)/usr/include"
  LDFLAGS+=" -L$(get_install_dir dvb-apps)/usr/lib"
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
    cp -P ${PKG_BUILD}/minisatip ${ADDON_BUILD}/${PKG_ADDON_ID}/bin
  mkdir -p ${ADDON_BUILD}/${PKG_ADDON_ID}/webif
    cp -PR ${PKG_BUILD}/html/* ${ADDON_BUILD}/${PKG_ADDON_ID}/webif
}
