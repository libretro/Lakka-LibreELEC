# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="crazycat"
PKG_VERSION="10.0-cc"
PKG_SHA256="66c298f178cac3bd5c2182cd42122c603bd9ae6e3abadc2ccc8be75112bd196e"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/crazycat69/media_build"
PKG_URL="https://github.com/LibreELEC/media_build/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_UNPACK="media_tree_cc"
PKG_SECTION="driver.dvb"
PKG_LONGDESC="DVB driver for TBS cards with CrazyCats additions"

PKG_IS_ADDON="embedded"
PKG_IS_KERNEL_PKG="yes"
PKG_ADDON_IS_STANDALONE="yes"
PKG_ADDON_NAME="DVB drivers for TBS"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

PKG_KERNEL_CFG_FILE=$(kernel_config_path) || die

if ! grep -q ^CONFIG_USB_PCI= ${PKG_KERNEL_CFG_FILE}; then
  PKG_PATCH_DIRS="disable-pci"
fi

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  export LDFLAGS=""
}

make_target() {
  cp -RP $(get_build_dir media_tree_cc)/* ${PKG_BUILD}/linux

  # make config all
  kernel_make VER=${KERNEL_VER} SRCDIR=$(kernel_path) allyesconfig

  # hack to workaround media_build bug
  if [ "${PROJECT}" = Rockchip ]; then
    sed -e 's/CONFIG_DVB_CXD2820R=m/# CONFIG_DVB_CXD2820R is not set/g' -i v4l/.config
    sed -e 's/CONFIG_DVB_LGDT3306A=m/# CONFIG_DVB_LGDT3306A is not set/g' -i v4l/.config
  fi

  # add menuconfig to edit .config
  kernel_make VER=${KERNEL_VER} SRCDIR=$(kernel_path)
}

makeinstall_target() {
  install_driver_addon_files "${PKG_BUILD}/v4l/"
}
