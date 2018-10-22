# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="oscam"
PKG_VERSION="57496438f69e92ad0b7b7797a05e34f0e512ac07"
PKG_SHA256="544df425690c8c7157fb9f0e69f497fec67bc3641247d9a45f0eb20c1c1d705b"
PKG_VERSION_NUMBER="11431"
PKG_REV="106"
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
