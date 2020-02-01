# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gnutls"
PKG_VERSION="3.6.12"
PKG_SHA256="bfacf16e342949ffd977a9232556092c47164bd26e166736cf3459a870506c4b"
PKG_LICENSE="LGPL2.1"
PKG_SITE="https://gnutls.org"
PKG_URL="https://www.gnupg.org/ftp/gcrypt/gnutls/v3.6/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libidn2 nettle zlib"
PKG_LONGDESC="A library which provides a secure layer over a reliable transport layer."

PKG_CONFIGURE_OPTS_TARGET="--disable-doc \
                           --disable-full-test-suite \
                           --disable-guile \
                           --disable-libdane \
                           --disable-padlock \
                           --disable-tests \
                           --disable-tools \
                           --disable-valgrind-tests \
                           --enable-local-libopts \
                           --with-idn \
                           --with-included-libtasn1 \
                           --with-included-unistring \
                           --without-p11-kit \
                           --without-tpm"
