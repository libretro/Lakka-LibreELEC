# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="oscam"
PKG_VERSION="a2ee0528f1de527748aaf7a79982ed112ffa3183"
PKG_SHA256="24315471faea612a25b39fc14050f4fad4365715fde48dcb0032ebdce770282d"
PKG_VERSION_NUMBER="11517"
PKG_REV="108"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.streamboard.tv/oscam/wiki"
PKG_URL="http://repo.or.cz/oscam.git/snapshot/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl pcsc-lite"
PKG_SECTION="service.softcam"
PKG_SHORTDESC="OSCam: an Open Source Conditional Access Modul"
PKG_LONGDESC="OSCam($PKG_VERSION_NUMBER) is a software to be used to decrypt digital television channels, as an alternative for a conditional access module."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="OSCam"
PKG_ADDON_TYPE="xbmc.service"

PKG_CMAKE_OPTS_TARGET="-DLIBUSBDIR=$SYSROOT_PREFIX/usr \
                       -DWITH_SSL=1 \
                       -DHAVE_LIBCRYPTO=1 \
                       -DHAVE_DVBAPI=1 \
                       -DWITH_STAPI=0 \
                       -DWEBIF=1 \
                       -DWITH_DEBUG=0 \
                       -DOPTIONAL_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include \
                       -DSTATIC_LIBUSB=1 \
                       -DCLOCKFIX=0 \
                       -DCARDREADER_DB2COM=OFF"

pre_configure_target() {
  export OSCAM_ADDON_VERSION="$PKG_VERSION_NUMBER"
}

makeinstall_target() {
  :
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $PKG_BUILD/.$TARGET_NAME/oscam $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -P $PKG_BUILD/.$TARGET_NAME/utils/list_smargo $ADDON_BUILD/$PKG_ADDON_ID/bin
}
