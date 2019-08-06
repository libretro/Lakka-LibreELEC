# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="comskip"
PKG_VERSION="14dffb241fac0126e261d4ff5bf929479e2592b6"
PKG_SHA256="025bfd532aa6ccfd513f4d88f34ec95a9b5a34c763ed13c17433b36415e5bfd4"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kaashoek.com/comskip/"
PKG_URL="https://github.com/erikkaashoek/Comskip/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain argtable2 ffmpeg gnutls"
PKG_LONGDESC="Comskip detects commercial breaks from a video stream. It can be used for post-processing recordings."
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  LDFLAGS+=" -ldl"

  export argtable2_CFLAGS="-I$(get_build_dir argtable2)/src"
  export argtable2_LIBS="-L$(get_build_dir argtable2)/src/.libs -largtable2"
}

make_target() {
 :
}
