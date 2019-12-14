# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libzen"
PKG_VERSION="0.4.37"
PKG_SHA256="38c0a68b715b55d6685d2759eecda040adf37bd066955d79a5d01f91977bd9a0"
PKG_LICENSE="GPL"
PKG_SITE="http://mediaarea.net/en/MediaInfo/"
PKG_URL="http://mediaarea.net/download/source/libzen/${PKG_VERSION}/libzen_${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MediaInfo is a convenient unified display of the most relevant technical and tag data for video and audio files"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-sysroot"

configure_target() {
  cd Project/GNU/Library
  do_autoreconf
  ./configure \
        --host=$TARGET_NAME \
        --build=$HOST_NAME \
        --enable-static \
        --disable-shared \
        --prefix=/usr
}

make_target() {
  make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/include/ZenLib $INSTALL/usr/lib/pkgconfig
  cp -aP ../../../Source/ZenLib/*.h $INSTALL/usr/include/ZenLib
  for i in HTTP_Client Format/Html Format/Http ; do
    mkdir -p $INSTALL/usr/include/ZenLib/$i/
    cp -aP ../../../Source/ZenLib/$i/*.h $INSTALL/usr/include/ZenLib/$i/
  done
  cp -P .libs/* $INSTALL/usr/lib
  cp -P libzen.pc $INSTALL/usr/lib/pkgconfig
}
