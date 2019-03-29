# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libmediainfo"
PKG_VERSION="18.05"
PKG_SHA256="76759613ca71d5659818e6ed121be9f31c552931b04939b0db4c58bc57cd5221" 
PKG_LICENSE="GPL"
PKG_SITE="http://mediaarea.net/en/MediaInfo/Download/Source"
PKG_URL="http://mediaarea.net/download/source/libmediainfo/${PKG_VERSION}/libmediainfo_${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libzen zlib"
PKG_LONGDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_TOOLCHAIN="manual"

make_target() {
  cd Project/GNU/Library
  do_autoreconf
  ./configure \
        --host=$TARGET_NAME \
        --build=$HOST_NAME \
        --enable-static \
        --disable-shared \
        --prefix=/usr \
        --enable-visibility
  make
}

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include/MediaInfo
  cp -aP ../../../Source/MediaInfo/* $SYSROOT_PREFIX/usr/include/MediaInfo
  for i in Archive Audio Duplicate Export Image Multiple Reader Tag Text Video ; do
    mkdir -p $SYSROOT_PREFIX/usr/include/MediaInfo/$i/
    cp -aP ../../../Source/MediaInfo/$i/*.h $SYSROOT_PREFIX/usr/include/MediaInfo/$i/
  done
  cp -P libmediainfo-config $TOOLCHAIN/bin
}
