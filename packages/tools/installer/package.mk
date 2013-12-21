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

PKG_NAME="installer"
PKG_VERSION="1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv/"
PKG_URL=""
PKG_DEPENDS="busybox dialog parted e2fsprogs syslinux"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="tools"
PKG_SHORTDESC="installer: OpenELEC.tv Install manager"
PKG_LONGDESC="OpenELEC.tv Install manager to install the system on any disk"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_ARCH" = "i386" -o "$TARGET_ARCH" = "x86_64" ]; then
  PKG_DEPENDS="$PKG_DEPENDS flashrom"
fi

make_target() {
  : # nothing to make here
}

makeinstall_target() {
  : # nothing to install here
}

post_install() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/installer $INSTALL/usr/bin

  mkdir -p $INSTALL/etc
    if [ -f $PROJECT_DIR/$PROJECT/installer/installer.conf ]; then
      cp $PROJECT_DIR/$PROJECT/installer/installer.conf $INSTALL/etc
    else
      cp $PKG_DIR/config/installer.conf $INSTALL/etc
    fi

  enable_service installer.service
}
