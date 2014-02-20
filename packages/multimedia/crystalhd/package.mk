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

PKG_NAME="crystalhd"
PKG_VERSION="3cb6786"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://git.linuxtv.org/jarod/crystalhd.git"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="crystalhd: OSX and Linux driver and library support for the Broadcom Crystal HD Video Accelerator."
PKG_LONGDESC="OSX and Linux driver and library support for the Broadcom Crystal HD Video Accelerator. Supported under XBMC for Mac on the AppleTV and under 10.4 and 10.5 OSX platforms."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  cd driver/linux
    autoreconf -vif
}

configure_target() {
  ./configure --host=$TARGET_NAME \
              --build=$HOST_NAME \
              --prefix=/usr \
              --with-kernel-path=$(kernel_path)
}

make_target() {
  LDFLAGS="" make V=1

  cd $ROOT/$PKG_BUILD/linux_lib/libcrystalhd
    make BCGCC=$TARGET_CXX
}

post_makeinstall_target() {
  cd $ROOT/$PKG_BUILD
    mkdir -p $INSTALL/usr/lib/udev/rules.d
      cp driver/linux/*.rules $INSTALL/usr/lib/udev/rules.d

    mkdir -p $INSTALL/lib/modules/$(get_module_dir)/crystalhd
      cp driver/linux/crystalhd.ko $INSTALL/lib/modules/$(get_module_dir)/crystalhd
}
