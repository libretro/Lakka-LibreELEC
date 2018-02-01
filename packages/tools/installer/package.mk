################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="installer"
PKG_VERSION="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libreelec.tv/"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain busybox newt parted e2fsprogs syslinux grub"
PKG_SECTION="tools"
PKG_SHORTDESC="installer: LibreELEC.tv Install manager"
PKG_LONGDESC="LibreELEC.tv Install manager to install the system on any disk"
PKG_TOOLCHAIN="manual"

post_install() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/installer $INSTALL/usr/bin
    sed -e "s/@DISTRONAME@/$DISTRONAME/g" \
        -i  $INSTALL/usr/bin/installer

  mkdir -p $INSTALL/etc
    find_file_path config/installer.conf
    cp ${FOUND_PATH} $INSTALL/etc
    sed -e "s/@SYSTEM_SIZE@/$SYSTEM_SIZE/g" \
        -e "s/@SYSTEM_PART_START@/$SYSTEM_PART_START/g" \
        -e "s/@EXTLINUX_PARAMETERS@/$EXTLINUX_PARAMETERS/g" \
        -i $INSTALL/etc/installer.conf

  enable_service installer.service
}
