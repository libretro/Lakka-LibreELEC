# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mediainfo"
PKG_VERSION="18.05"
PKG_SHA256="d94093aaf910759f302fb6b5ac23540a217eb940cfbb21834de2381de975fa65"
PKG_LICENSE="GPL"
PKG_SITE="http://mediaarea.net/en/MediaInfo/Download/Source"
PKG_URL="http://mediaarea.net/download/source/mediainfo/${PKG_VERSION}/mediainfo_${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libmediainfo"
PKG_LONGDESC="A convenient unified display of the most relevant technical and tag data for video and audio files."
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -L$(get_build_dir libmediainfo)/Project/GNU/Library/.libs -L$(get_build_dir libzen)/Project/GNU/Library/.libs"
  export LIBS="-lmediainfo -lzen"
}

make_target() {
  cd Project/GNU/CLI
  do_autoreconf
  echo $PATH
  ./configure \
        --host=$TARGET_NAME \
        --build=$HOST_NAME \
        --prefix=/usr
  make
}
