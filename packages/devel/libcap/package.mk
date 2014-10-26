################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2010-2011 Roman Weber (roman@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libcap"
PKG_VERSION="2.24"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="http://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain attr"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="libcap: A library for getting and setting POSIX.1e capabilities"
PKG_LONGDESC="As of Linux 2.2.0, the power of the superuser has been partitioned into a set of discrete capabilities (in other places, these capabilities are know as privileges). The contents of the libcap package are a library and a number of simple programs that are intended to show how an application/daemon can be protected (with wrappers) or rewritten to take advantage of this fine grained approach to constraining the danger to your system from programs running as 'root'."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make CC=$TARGET_CC \
       AR=$TARGET_AR \
       RANLIB=$TARGET_RANLIB \
       CFLAGS="$TARGET_CFLAGS" \
       BUILD_CC=$HOST_CC \
       BUILD_CFLAGS="$HOST_CFLAGS -I$ROOT/$PKG_BUILD/libcap/include" \
       PAM_CAP=no \
       lib=/lib \
       -C libcap libcap.pc libcap.a
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp libcap/libcap.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp libcap/libcap.pc $SYSROOT_PREFIX/usr/lib/pkgconfig

  mkdir -p $SYSROOT_PREFIX/usr/include/sys
    cp libcap/include/sys/capability.h $SYSROOT_PREFIX/usr/include/sys
}
