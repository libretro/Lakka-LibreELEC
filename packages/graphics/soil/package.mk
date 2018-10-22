# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="soil"
PKG_VERSION="1.16"
PKG_SHA256="5f2d8a8c78e81d29df07f0f97c34fa2f75187bcadfdc7222cbd026859acaff2f"
PKG_LICENSE="CCPL"
PKG_SITE="http://www.lonesock.net/soil.html"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain mesa"
PKG_LONGDESC="A tiny C lib primarily for loading textures into OpenGL"
PKG_BUILD_FLAGS="+pic"

pre_make_target() {
  sed "s/1.07-20071110/$PKG_VERSION/" -i Makefile
}

pre_makeinstall_target() {
  export DESTDIR=$SYSROOT_PREFIX
}
