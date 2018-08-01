# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hauppauge"
PKG_VERSION="f5a5e5e"
PKG_SHA256="6a3167c9990fa96838f4746861edb4d4e656739ea08d4f993e54becb9f2e9ab2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://git.linuxtv.org/media_build.git"
PKG_URL="https://git.linuxtv.org/media_build.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain linux media_tree"
PKG_NEED_UNPACK="$LINUX_DEPENDS media_tree"
PKG_SECTION="driver.dvb"
PKG_LONGDESC="DVB drivers for Hauppauge"

PKG_IS_ADDON="embedded"
PKG_IS_KERNEL_PKG="yes"
PKG_ADDON_IS_STANDALONE="yes"
PKG_ADDON_NAME="DVB drivers for Hauppauge"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

if [ $LINUX = "amlogic-3.14" -o $LINUX = "amlogic-3.10" ]; then
  PKG_PATCH_DIRS="amlogic"
fi

pre_make_target() {
  export KERNEL_VER=$(get_module_dir)
  export LDFLAGS=""
}

make_target() {
  cp -RP $(get_build_dir media_tree)/* $PKG_BUILD/linux
  kernel_make VER=$KERNEL_VER SRCDIR=$(kernel_path) stagingconfig

  # hack to workaround media_build bug
  if [ $LINUX = "amlogic-3.14" -o $LINUX = "amlogic-3.10" ]; then
    sed -e 's/CONFIG_VIDEO_TVP5150=m/# CONFIG_VIDEO_TVP5150 is not set/g' -i v4l/.config
    sed -e 's/CONFIG_DVB_LGDT3306A=m/# CONFIG_DVB_LGDT3306A is not set/g' -i v4l/.config
    sed -e 's/CONFIG_VIDEO_S5C73M3=m/# CONFIG_VIDEO_S5C73M3 is not set/g' -i v4l/.config
  fi

  kernel_make VER=$KERNEL_VER SRCDIR=$(kernel_path)
}

makeinstall_target() {
  install_driver_addon_files "$PKG_BUILD/v4l/"
}
