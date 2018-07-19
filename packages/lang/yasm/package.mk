# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="yasm"
PKG_VERSION="1.3.0"
PKG_SHA256="3dce6601b495f5b3d45b59f7d2492a340ee7e84b5beca17e48f862502bd5603f"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.tortall.net/projects/yasm/"
PKG_URL="http://www.tortall.net/projects/yasm/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_SECTION="toolchain/lang"
PKG_SHORTDESC="yasm: A complete rewrite of the NASM assembler"
PKG_LONGDESC="Yasm is a complete rewrite of the NASM assembler under the new BSD License (some portions are under other licenses, see COPYING for details). It is designed from the ground up to allow for multiple assembler syntaxes to be supported (eg, NASM, TASM, GAS, etc.) in addition to multiple output object formats and even multiple instruction sets. Another primary module of the overall design is an optimizer module."
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
