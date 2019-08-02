# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvb-latest"
PKG_VERSION="0f25e6fb13b6bc345218800ad9ac863deb2ee9c8"
PKG_SHA256="71294995cff2bc556bcf9aa7ade595a4ccd91a1972b73d1e537d99d2ce86dbed"
PKG_LICENSE="GPL"
PKG_SITE="http://git.linuxtv.org/media_build.git"
PKG_URL="https://git.linuxtv.org/media_build.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux media_tree"
PKG_NEED_UNPACK="$LINUX_DEPENDS $(get_pkg_directory media_tree)"
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
