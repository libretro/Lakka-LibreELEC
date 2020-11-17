# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="squeezelite"
PKG_VERSION="cf2230bd8edb9397cafe97c94cda1836269ba7d9"
PKG_SHA256="fd1f02b802780e96ef38649e4f2c3e6dfaddefcd33b321a8dbf6f82955f903f4"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/ralph-irving/squeezelite"
PKG_URL="https://github.com/ralph-irving/squeezelite/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain faad2 ffmpeg flac libmad libvorbis mpg123 soxr libogg"
PKG_DEPENDS_CONFIG="mpg123"
PKG_LONGDESC="A client for the Logitech Media Server."
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  make \
    OPTS="-DDSD -DFFMPEG -DRESAMPLE -DVISEXPORT -DLINKALL" \
    CFLAGS="$CFLAGS $(pkg-config --cflags libmpg123 vorbisfile vorbis ogg)" \
    LDFLAGS="$LDFLAGS $(pkg-config --libs libmpg123 vorbisfile vorbis ogg)"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp -p squeezelite $INSTALL/usr/bin
}
