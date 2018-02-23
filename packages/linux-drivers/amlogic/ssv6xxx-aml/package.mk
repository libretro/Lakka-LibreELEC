################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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
PKG_VERSION="1041e7d"
PKG_SHA256="1d96db8eec06c8a2c43f2c8024cc573e2bbce08fb0504fd9b6671224335e7d5f"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="http://libreelec.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver"
PKG_SHORTDESC="ssv6xxx Linux driver"
PKG_LONGDESC="ssv6xxx Linux driver"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  sed -i 's,hw_cap_p2p = on,hw_cap_p2p = off,g' firmware/ssv6051-wifi.cfg
}

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  if [ "$TARGET_KERNEL_ARCH" = "arm64" ]; then
    PLATFORM="aml-s905"
  else
    PLATFORM="aml-s805"
  fi

  cd $PKG_BUILD
    ./ver_info.pl include/ssv_version.h
    cp Makefile.android Makefile
    sed -i 's,PLATFORMS =,PLATFORMS = '"$PLATFORM"',g' Makefile
    make module SSV_ARCH="$TARGET_KERNEL_ARCH" \
      SSV_CROSS="$TARGET_KERNEL_PREFIX" \
      SSV_KERNEL_PATH="$(kernel_path)"
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    find $PKG_BUILD/ -name \*.ko -not -path '*/\.*' -exec cp {} $INSTALL/$(get_full_module_dir)/$PKG_NAME \;

  mkdir -p $INSTALL/$(get_full_firmware_dir)/ssv6051
    cp $PKG_BUILD/firmware/* $INSTALL/$(get_full_firmware_dir)/ssv6051
}
