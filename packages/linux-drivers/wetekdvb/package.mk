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

PKG_NAME="wetekdvb"
PKG_VERSION="20160307"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.wetek.com/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="wetekdvb: Wetek DVB driver"
PKG_LONGDESC="These package contains Wetek's DVB driver "

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
    cp driver/*.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME

  mkdir -p $INSTALL/lib/firmware
    cp firmware/* $INSTALL/lib/firmware
}
