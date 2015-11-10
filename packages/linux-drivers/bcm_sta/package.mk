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

# Downloadlocation:
# http://www.broadcom.com/support/802.11/linux_sta.php

PKG_NAME="bcm_sta"
PKG_VERSION="6.30.223.271"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="driver"
PKG_SHORTDESC="bcm_sta: Broadcom's BCM4311-, BCM4312-, BCM4313-, BCM4321-, BCM4322-, BCM43224-, and BCM43225-based WLAN driver"
PKG_LONGDESC="These packages contain Broadcom's IEEE 802.11a/b/g/n hybrid Linux® device driver for use with Broadcom's BCM4311-, BCM4312-, BCM4313-, BCM4321-, BCM4322-, BCM43224-, and BCM43225-based hardware. There are different tars for 32-bit and 64-bit x86 CPU architectures. Make sure that you download the appropriate tar because the hybrid binary file must be of the appropriate architecture type. The hybrid binary file is agnostic to the specific version of the Linux kernel because it is designed to perform all interactions with the operating system through operating-system-specific files and an operating system abstraction layer file. All Linux operating-system-specific code is provided in source form, making it possible to retarget to different kernel versions and fix operating system related issues."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd x86-64
    KBUILD_NOPEDANTIC=1 make V=1 CC=$CC -C $(kernel_path) M=`pwd` BINARCH=$TARGET_ARCH
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/bcm_sta
    cp *.ko $INSTALL/lib/modules/$(get_module_dir)/$PKG_NAME
}
