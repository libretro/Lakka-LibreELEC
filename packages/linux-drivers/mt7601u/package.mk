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

PKG_NAME="mt7601u"
PKG_VERSION="e65aed5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/porjo/mt7601"
PKG_URL="http://down.nu/packages/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="Mediatek MT7601U Linux 3.x driver"
PKG_LONGDESC="Mediatek MT7601U Linux 3.x driver"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  sed -i '200s|.*LINUX_SRC.*|LINUX_SRC = '$(kernel_path)'|' src/Makefile
  sed -i '203s|.*LINUX_SRC_MODULE.*|LINUX_SRC_MODULE = '$INSTALL'/usr/lib/modules/'$(get_module_dir)'/kernel/drivers/net/wireless/|' src/Makefile
  sed -i '204s|.*CROSS_COMPILE.*|CROSS_COMPILE = $(TARGET_PREFIX)|' src/Makefile
  sed -i '205i ARCH = $(TARGET_ARCH)' src/Makefile
  sed -i '206i export ARCH' src/Makefile
  sed -i '207i export CROSS_COMPILE' src/Makefile
  make -C src osdrv
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
    cp src/os/linux/mt7601Usta.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME

  mkdir -p $INSTALL/usr/lib/firmware/mt7601u
    cp src/RT2870STA.dat $INSTALL/usr/lib/firmware/mt7601u/mt7601u_sta.dat
}
