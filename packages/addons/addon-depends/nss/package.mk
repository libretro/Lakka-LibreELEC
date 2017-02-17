################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="nss"
PKG_VERSION="3.27.1"
PKG_ARCH="any"
PKG_LICENSE="Mozilla Public License"
PKG_SITE="http://ftp.mozilla.org/"
PKG_URL="http://ftp.mozilla.org/pub/security/nss/releases/NSS_3_27_1_RTM/src/nss-3.27.1-with-nspr-4.13.tar.gz"
PKG_DEPENDS_TARGET="toolchain nss:host nspr zlib"
PKG_SECTION="security"
PKG_SHORTDESC="The Network Security Services (NSS) package is a set of libraries designed to support cross-platform development of security-enabled client and server applications"
PKG_LONGDESC="The Network Security Services (NSS) package is a set of libraries designed to support cross-platform development of security-enabled client and server applications"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

MAKEFLAGS=-j1

make_host() {
  cd $PKG_BUILD/nss

  [ "$TARGET_ARCH" = "x86_64" ] && export USE_64=1

  make -C coreconf/nsinstall  
}

makeinstall_host() {
  cp $PKG_BUILD/nss/coreconf/nsinstall/*/nsinstall $TOOLCHAIN/bin
}

post_makeinstall_host() {
  rm -rf $PKG_BUILD/nss/coreconf/nsinstall/Linux*
}

make_target() {
  cd $PKG_BUILD/nss

  [ "$TARGET_ARCH" = "x86_64" ] && TARGET_USE_64="USE_64=1"

  make BUILD_OPT=1 $TARGET_USE_64 \
     NSPR_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include/nspr \
     USE_SYSTEM_ZLIB=1 ZLIB_LIBS=-lz \
     OS_TEST=$TARGET_ARCH \
     NSS_TESTS="dummy" \
     NSINSTALL=$TOOLCHAIN/bin/nsinstall \
     CPU_ARCH_TAG=$TARGET_ARCH \
     CC=$CC LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib" \
     V=1
}

makeinstall_target() {
  cd $PKG_BUILD
  $STRIP dist/Linux*/lib/*.so
  cp -L dist/Linux*/lib/*.so $SYSROOT_PREFIX/usr/lib
  cp -L dist/Linux*/lib/libcrmf.a $SYSROOT_PREFIX/usr/lib
  mkdir -p $SYSROOT_PREFIX/usr/include/nss
  cp -RL dist/{public,private}/nss/* $SYSROOT_PREFIX/usr/include/nss
  cp -L dist/Linux*/lib/pkgconfig/nss.pc $SYSROOT_PREFIX/usr/lib/pkgconfig
}
