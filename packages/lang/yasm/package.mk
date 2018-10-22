# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="yasm"
PKG_VERSION="1.3.0"
PKG_SHA256="3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f"
PKG_LICENSE="BSD"
PKG_SITE="http://www.tortall.net/projects/yasm/"
PKG_URL="http://www.tortall.net/projects/yasm/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="A complete rewrite of the NASM assembler under the new BSD License."
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_HOST="--disable-debug \
                         --disable-warnerror \
                         --disable-profiling \
                         --disable-gcov \
                         --disable-python \
                         --disable-python-bindings \
                         --enable-nls \
                         --disable-rpath \
                         --without-dmalloc \
                         --with-gnu-ld \
                         --without-libiconv-prefix \
                         --without-libintl-prefix"
