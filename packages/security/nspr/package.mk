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

PKG_NAME="nspr"
PKG_VERSION="4.13.1"
PKG_ARCH="any"
PKG_LICENSE="Mozilla Public License"
PKG_SITE="http://www.linuxfromscratch.org/blfs/view/svn/general/nspr.html"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain nss:host"
PKG_SECTION="security"
PKG_SHORTDESC="Netscape Portable Runtime (NSPR) provides a platform-neutral API for system level and libc like functions"
PKG_LONGDESC="Netscape Portable Runtime (NSPR) provides a platform-neutral API for system level and libc like functions"
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="-parallel"

if [ "$TARGET_ARCH" = "x86_64" ] ; then
  TARGET_USE_64="--enable-64bit"
fi

PKG_CONFIGURE_OPTS_TARGET="--with-pthreads $TARGET_USE_64"
PKG_MAKE_OPTS_TARGET="NSINSTALL=$TOOLCHAIN/bin/nsinstall"
PKG_MAKEINSTALL_OPTS_TARGET="NSINSTALL=$TOOLCHAIN/bin/nsinstall"

configure_host() {
  cd $(get_build_dir nss)/nspr
  ./configure --with-pthreads --enable-64bit --with-pthreads --prefix=$TOOLCHAIN
}

pre_make_host() {
  cd $(get_build_dir nss)/nspr
  make clean
}

configure_target() {
  cd $(get_build_dir nss)/nspr
  ./configure --with-pthreads $TARGET_USE_64 $TARGET_CONFIGURE_OPTS
}

pre_make_target() {
  cd $(get_build_dir nss)/nspr
  make clean
}
