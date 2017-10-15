################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2012 Yann Cézard (eesprit@free.fr)
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

PKG_NAME="open-iscsi"
PKG_VERSION="bf39941"
PKG_SHA256="92b9f0a27a9a373b14eab7b12f1bfff5d4857695a688dc4434df8e7623354588"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/mikechristie/open-iscsi"
PKG_URL="https://github.com/mikechristie/open-iscsi/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_INIT="toolchain util-linux"
PKG_SECTION="initramfs/system"
PKG_SHORTDESC="open-iscsi: system utilities for Linux to access iSCSI targets"
PKG_LONGDESC="The open-iscsi package allows you to mount iSCSI targets. This package add support for using iscsi target as root device."
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_INIT="user"

pre_configure_init() {
  export OPTFLAGS="$CFLAGS $LDFLAGS"
}

configure_init() {
  cd utils/open-isns
    ./configure --host=$TARGET_NAME \
                --build=$HOST_NAME \
                --with-security=no
  cd ../..
}

makeinstall_init() {
  mkdir -p $INSTALL/usr/sbin
    cp -P $PKG_BUILD/usr/iscsistart $INSTALL/usr/sbin
}
