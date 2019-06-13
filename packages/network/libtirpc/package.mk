# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libtirpc"
PKG_VERSION="1.1.4"
PKG_SHA256="2ca529f02292e10c158562295a1ffd95d2ce8af97820e3534fe1b0e3aec7561d"
PKG_LICENSE="GPL"
PKG_SITE="https://sourceforge.net/projects/libtirpc/"
PKG_URL="https://downloads.sourceforge.net/project/libtirpc/libtirpc/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of Suns Transport-Independent RPC library to Linux."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           --disable-silent-rules \
                           --enable-ipv6 \
                           --disable-gssapi \
                           --with-gnu-ld"
