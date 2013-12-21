################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)
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
#  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="open-iscsi"
PKG_VERSION="bf39941"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/mikechristie/open-iscsi"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_INIT=""
PKG_BUILD_DEPENDS_INIT="toolchain util-linux"
PKG_PRIORITY="optional"
PKG_SECTION="initramfs/system"
PKG_SHORTDESC="open-iscsi: system utilities for Linux to access iSCSI targets"
PKG_LONGDESC="The open-iscsi package allows you to mount iSCSI targets. This package add support for using iscsi target as root device."

PKG_IS_ADDON="no"
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
  mkdir -p $INSTALL/sbin
    cp -P $ROOT/$PKG_BUILD/usr/iscsistart $INSTALL/sbin
}
