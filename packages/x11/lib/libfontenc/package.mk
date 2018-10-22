# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libfontenc"
PKG_VERSION="1.1.3"
PKG_SHA256="70588930e6fc9542ff38e0884778fbc6e6febf21adbab92fd8f524fe60aefd21"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/lib/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros zlib font-util"
PKG_LONGDESC="Libfontenc is a library which helps font libraries portably determine and deal with different encodings of fonts."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
