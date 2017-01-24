################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2016 Christian Hewitt (chewitt@openelec.tv)
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

PKG_NAME="mt7610u"
PKG_VERSION="34a7865"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
# mediatek: PKG_SITE="http://www.mediatek.com/en/downloads/mt7610u-usb/"
PKG_SITE="https://github.com/sohaib17/mt7610u"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Mediatek mt7610u Linux driver"
PKG_LONGDESC="Mediatek mt7610u Linux driver"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {

  sed -i '198s|.*LINUX_SRC.*|LINUX_SRC = '$(kernel_path)'|' Makefile
  sed -i '199s|.*LINUX_SRC_MODULE.*|LINUX_SRC_MODULE = '$INSTALL'/usr/lib/modules/'$(get_module_dir)'/kernel/drivers/net/wireless/|' Makefile
  make osdrv

}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
    cp os/linux/mt7610u_sta.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME

  mkdir -p $INSTALL/usr/lib/firmware/mt7610u
    cp RT2870STA.dat $INSTALL/usr/lib/firmware/mt7610u/mt7610u_sta.dat
}
