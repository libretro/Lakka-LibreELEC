# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gettext"
PKG_VERSION="0.19.8.1"
PKG_SHA256="ff942af0e438ced4a8b0ea4b0b6e0d6d657157c5e2364de57baa279c1c125c43"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/s/gettext/"
PKG_URL="http://ftp.gnu.org/pub/gnu/gettext/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="A program internationalization library and tools."

configure_package() {
  PKG_CONFIGURE_SCRIPT="${PKG_BUILD}/gettext-tools/configure"

  PKG_CONFIGURE_OPTS_HOST="--enable-static --disable-shared \
                           --disable-rpath \
                           --with-gnu-ld \
                           --disable-java \
                           --disable-curses \
                           --with-included-libxml \
                           --disable-native-java \
                           --disable-csharp \
                           --without-emacs"
}
