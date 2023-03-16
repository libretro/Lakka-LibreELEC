# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="encodings"
PKG_VERSION="1.0.7"
PKG_SHA256="3a39a9f43b16521cdbd9f810090952af4f109b44fa7a865cd555f8febcea70a4"
PKG_LICENSE="OSS"
PKG_SITE="https://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/font/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros font-util:host"
PKG_LONGDESC="X font encoding meta files."

PKG_CONFIGURE_OPTS_TARGET="--enable-gzip-small-encodings \
                           --enable-gzip-large-encodings \
                           --with-fontrootdir=/usr/share/fonts"
