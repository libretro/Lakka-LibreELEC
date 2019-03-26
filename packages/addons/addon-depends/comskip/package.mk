# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="comskip"
PKG_VERSION="6030aa0d3b589161ec96c6c986c48aa826fb9f72"
PKG_SHA256="df0b4b0354aef5acc17e4e94a20a396fa69c474af7579c94aad09dd490e0ee38"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kaashoek.com/comskip/"
PKG_URL="https://github.com/erikkaashoek/Comskip/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain argtable2 ffmpeg"
PKG_LONGDESC="Comskip detects commercial breaks from a video stream. It can be used for post-processing recordings."
PKG_TOOLCHAIN="autotools"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -ldl"

  export argtable2_CFLAGS="-I$(get_build_dir argtable2)/src"
  export argtable2_LIBS="-L$(get_build_dir argtable2)/src/.libs -largtable2"
}

make_target() {
 :
}
