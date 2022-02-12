# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libxml2"
PKG_VERSION="2.9.10"
PKG_SHA256="aafee193ffb8fe0c82d4afef6ef91972cbaf5feea100edc2f262750611b4be1f"
PKG_LICENSE="MIT"
PKG_SITE="http://xmlsoft.org"
PKG_URL="ftp://xmlsoft.org/libxml2/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="zlib:host Python3:host"
PKG_DEPENDS_TARGET="toolchain zlib"
PKG_LONGDESC="The libxml package contains an XML library, which allows you to manipulate XML files."

PKG_CONFIGURE_OPTS_ALL="ac_cv_header_ansidecl_h=no \
                        --enable-static \
                        --enable-shared \
                        --disable-silent-rules \
                        --enable-ipv6 \
                        --without-lzma"

PKG_CONFIGURE_OPTS_HOST="${PKG_CONFIGURE_OPTS_ALL} \
                         --with-zlib=${TOOLCHAIN} \
                         --with-python"

PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_ALL} \
                           --with-zlib=${SYSROOT_PREFIX}/usr \
                           --without-python \
                           --with-sysroot=${SYSROOT_PREFIX}"

post_makeinstall_target() {
  sed -e "s:\(['= ]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" -i ${SYSROOT_PREFIX}/usr/bin/xml2-config

  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/lib/xml2Conf.sh
}
