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
PKG_VERSION="3.29.5"
PKG_SHA256="8cb8624147737d1b4587c50bf058afbb6effc0f3c205d69b5ef4077b3bfed0e4"
PKG_ARCH="any"
PKG_LICENSE="Mozilla Public License"
PKG_SITE="http://ftp.mozilla.org/"
PKG_URL="http://ftp.mozilla.org/pub/security/nss/releases/NSS_3_29_5_RTM/src/nss-3.29.5-with-nspr-4.13.1.tar.gz"
PKG_DEPENDS_HOST="nspr:host zlib:host"
PKG_DEPENDS_TARGET="toolchain nss:host nspr zlib sqlite"
PKG_SECTION="security"
PKG_SHORTDESC="The Network Security Services (NSS) package is a set of libraries designed to support cross-platform development of security-enabled client and server applications"
PKG_LONGDESC="The Network Security Services (NSS) package is a set of libraries designed to support cross-platform development of security-enabled client and server applications"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-parallel"

make_host() {
  cd $PKG_BUILD/nss

  make clean || true
  rm -rf $PKG_BUILD/dist

  INCLUDES="-I$TOOLCHAIN/include" \
  make BUILD_OPT=1 USE_64=1 \
     PREFIX=$TOOLCHAIN \
     NSPR_INCLUDE_DIR=$TOOLCHAIN/include/nspr \
     USE_SYSTEM_ZLIB=1 ZLIB_LIBS="-lz -L$TOOLCHAIN/lib" \
     SKIP_SHLIBSIGN=1 \
     NSS_TESTS="dummy" \
     CC=$CC LDFLAGS="$LDFLAGS -L$TOOLCHAIN/lib" \
     V=1
}

makeinstall_host() {
  cd $PKG_BUILD
  $STRIP dist/Linux*/lib/*.so
  cp -L dist/Linux*/lib/*.so $TOOLCHAIN/lib
  cp -L dist/Linux*/lib/libcrmf.a $TOOLCHAIN/lib
  mkdir -p $TOOLCHAIN/include/nss
  cp -RL dist/{public,private}/nss/* $TOOLCHAIN/include/nss
  cp -L dist/Linux*/lib/pkgconfig/nss.pc $TOOLCHAIN/lib/pkgconfig
  cp -L nss/coreconf/nsinstall/*/nsinstall $TOOLCHAIN/bin
}

make_target() {
  cd $PKG_BUILD/nss

  local TARGET_USE_64=""
  [ "$TARGET_ARCH" = "x86_64" -o "$TARGET_ARCH" = "aarch64" ] && TARGET_USE_64="USE_64=1"

  make clean || true
  rm -rf $PKG_BUILD/dist

  make BUILD_OPT=1 $TARGET_USE_64 \
     NSS_USE_SYSTEM_SQLITE=1 \
     NSPR_INCLUDE_DIR=$SYSROOT_PREFIX/usr/include/nspr \
     NSS_USE_SYSTEM_SQLITE=1 \
     USE_SYSTEM_ZLIB=1 ZLIB_LIBS=-lz \
     SKIP_SHLIBSIGN=1 \
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

  mkdir -p .install_pkg/usr/lib
    cp -PL dist/Linux*/lib/*.so .install_pkg/usr/lib
}
