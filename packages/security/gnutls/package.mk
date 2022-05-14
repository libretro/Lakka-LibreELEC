# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gnutls"
PKG_VERSION="3.7.6"
PKG_SHA256="77065719a345bfb18faa250134be4c53bef70c1bd61f6c0c23ceb8b44f0262ff"
PKG_LICENSE="LGPL2.1"
PKG_SITE="https://gnutls.org"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/gnutls/v${PKG_VERSION:0:3}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libidn2 nettle zlib"
PKG_LONGDESC="A library which provides a secure layer over a reliable transport layer."

PKG_CONFIGURE_OPTS_TARGET="--disable-doc \
                           --disable-full-test-suite \
                           --disable-guile \
                           --disable-libdane \
                           --disable-padlock \
                           --disable-rpath \
                           --disable-tests \
                           --disable-tools \
                           --disable-valgrind-tests \
                           --with-idn \
                           --with-included-libtasn1 \
                           --with-included-unistring \
                           --without-p11-kit \
                           --without-tpm"

post_configure_target() {
  libtool_remove_rpath libtool
}
