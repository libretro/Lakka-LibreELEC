# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="encodings"
PKG_VERSION="1.0.4"
PKG_SHA256="ced6312988a45d23812c2ac708b4595f63fd7a49c4dcd9f66bdcd50d1057d539"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/font/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros font-util:host"
PKG_LONGDESC="X font encoding meta files."

PKG_CONFIGURE_OPTS_TARGET="--enable-gzip-small-encodings \
                           --enable-gzip-large-encodings \
                           --with-fontrootdir=/usr/share/fonts"
