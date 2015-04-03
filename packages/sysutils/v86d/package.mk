################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="v86d"
PKG_VERSION="0.1.10"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://dev.gentoo.org/~spock/projects/uvesafb/"
PKG_URL="http://dev.gentoo.org/~spock/projects/uvesafb/archive/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_INIT="toolchain gcc:init"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="v86d: A userspace helper that runs x86 code in an emulated environment."
PKG_LONGDESC="v86d is the userspace helper that runs x86 code in an emulated environment. uvesafb will not work without v86d. v86d currently supports the x86 and amd64 (x86-64) architectures."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

INIT_CONFIGURE_OPTS="--with-x86emu"

pre_configure_init() {
# v86d fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME-init
}
