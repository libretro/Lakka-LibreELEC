# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-robotv"
PKG_VERSION="13b691af63743ce6481e2558dc50ee89dd7a0349"
PKG_SHA256="1bd508383d3b393dd1273af9bef07a1a64ac22c8eada85c96e5aa541c3abf228"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/pipelka/roboTV"
PKG_URL="https://github.com/pipelka/vdr-plugin-robotv/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr avahi"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="RoboTV is a Android TV based frontend for VDR."
PKG_TOOLCHAIN="cmake"

pre_configure_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include
  export VDRDIR=$VDR_DIR
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  cp --remove-destination $PKG_BUILD/.$TARGET_NAME/${LIB_NAME}.so $PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
}
