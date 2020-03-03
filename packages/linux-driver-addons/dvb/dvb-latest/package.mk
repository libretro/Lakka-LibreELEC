# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvb-latest"
PKG_VERSION="d1db2a6142b75428f972165fe647a0d01345e085"
PKG_SHA256="97fb72725f60f0cb5f4fd1b2fcf2d5f02fd2b8276d7cf48f5a10f3bef1ba2b8d"
PKG_LICENSE="GPL"
PKG_SITE="http://git.linuxtv.org/media_build.git"
PKG_URL="https://github.com/LibreELEC/media_build/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_UNPACK="media_tree"
PKG_SECTION="driver.dvb"
PKG_LONGDESC="DVB drivers from the latest kernel (media_build)"

PKG_IS_ADDON="embedded"
PKG_IS_KERNEL_PKG="yes"
PKG_ADDON_IS_STANDALONE="yes"
PKG_ADDON_NAME="DVB drivers from the latest kernel"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

PKG_KERNEL_CFG_FILE=$(kernel_config_path) || die

if ! grep -q ^CONFIG_USB_PCI= ${PKG_KERNEL_CFG_FILE} ; then
  PKG_PATCH_DIRS="disable-pci"
fi

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  export LDFLAGS=""
}

make_target() {
  cp -RP $(get_build_dir media_tree)/* $PKG_BUILD/linux

  # make config all
  kernel_make VER=$KERNEL_VER SRCDIR=$(kernel_path) allyesconfig

  kernel_make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  install_driver_addon_files "$PKG_BUILD/v4l/"
}
