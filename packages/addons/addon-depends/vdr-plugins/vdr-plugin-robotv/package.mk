# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-robotv"
PKG_VERSION="50d4bdcdbe3bdb6e85fe02de4c4086ca1f8db94d"
PKG_SHA256="062489e55111f0ba2420463cc506865ac59b1c1d080b318cb81d58ec3f4fbd3f"
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
