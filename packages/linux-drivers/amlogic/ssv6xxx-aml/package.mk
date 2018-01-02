################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2016 kszaq
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="ssv6xxx-aml"
PKG_REV="1"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_VERSION="1041e7d"
PKG_URL="http://kszaq.libreelec.tv/sources/ssv6xxx-$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="ssv6xxx-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="ssv6xxx-aml"
PKG_LONGDESC="ssv6xxx-aml"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-linux-gnu:host"
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
  TARGET_PREFIX=aarch64-linux-gnu-
fi

pre_configure_target() {
  sed -i 's,hw_cap_p2p = on,hw_cap_p2p = off,g' ssv6051/firmware/ssv6051-wifi.cfg
}

make_target() {
  if [ "$TARGET_KERNEL_ARCH" = "arm64" ]; then
    PLATFORM="aml-s905"
  else
    PLATFORM="aml-s805"
  fi

  cd $PKG_BUILD/ssv6051
    ./ver_info.pl include/ssv_version.h
    cp Makefile.android Makefile
    sed -i 's,PLATFORMS =,PLATFORMS = '"$PLATFORM"',g' Makefile
    LDFLAGS="" SSV_ARCH="$TARGET_KERNEL_ARCH" SSV_CROSS="$TARGET_PREFIX" SSV_KERNEL_PATH="$(kernel_path)" make module
}

makeinstall_target() {
  # kernel module
  mkdir -p $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME
    cp $PKG_BUILD/ssv6051/ssv6051.ko $INSTALL/usr/lib/modules/$(get_module_dir)/$PKG_NAME/

  # firmware
  mkdir -p $INSTALL/usr/lib/firmware/ssv6051
    cp $PKG_BUILD/ssv6051/firmware/* $INSTALL/usr/lib/firmware/ssv6051/
}
