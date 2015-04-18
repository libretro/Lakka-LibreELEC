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

PKG_NAME="mt7601u"
PKG_VERSION="ba391b3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
# mediatek: PKG_SITE="http://www.mediatek.com/en/downloads/mt7601u-usb/"
PKG_SITE="https://github.com/kuba-moo/mt7601u"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="mt7601u linux 3.19+ driver"
PKG_LONGDESC="mt7601u linux 3.19+ driver"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  KDIR=$(kernel_path) make
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
    cp $ROOT/$PKG_BUILD/mt7601u.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
}
