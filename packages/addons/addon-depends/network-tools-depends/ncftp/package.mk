# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ncftp"
PKG_VERSION="3.2.7"
PKG_SHA256="d41c5c4d6614a8eae2ed4e4d7ada6b6d3afcc9fb65a4ed9b8711344bef24f7e8"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.ncftp.com/ncftp/"
PKG_URL="https://www.ncftp.com/public_ftp/ncftp/ncftp-${PKG_VERSION}-src.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="NcFTP is a set of application programs implementing the File Transfer Protocol."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_header_librtmp_rtmp_h=yes \
            --enable-readline \
            --disable-universal \
            --disable-ccdv \
            --without-curses"

pre_configure_target() {
  export CFLAGS="${CFLAGS} -I../ -DHAVE_STDLIB_H=1"

  #workaround gcc-14 erroring with incompatible pointer type
  CFLAGS+=" -Wno-incompatible-pointer-types"
}

pre_build_target() {
  mkdir -p ${PKG_BUILD}/.${TARGET_NAME}
  cp -RP ${PKG_BUILD}/* ${PKG_BUILD}/.${TARGET_NAME}
}
