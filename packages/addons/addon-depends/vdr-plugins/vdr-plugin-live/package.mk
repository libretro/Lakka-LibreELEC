# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-live"
PKG_VERSION="e582514ede475574842b44ca6792335ff141172d"
PKG_SHA256="74deb2ca43ffb5779b3f9ff6f34c8b53898a226fcf92605d7ede0401cb62601c"
PKG_LICENSE="GPL"
PKG_SITE="http://live.vdr-developer.org/en/index.php"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-live/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr tntnet pcre:host pcre"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="Allows a comfortable operation of VDR and some of its plugins trough a web interface."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib/iconv"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  make VDRDIR=$VDR_DIR \
    LIBDIR="." \
    LOCALEDIR="./locale"

  cp --remove-destination $PKG_BUILD/${LIB_NAME}.so $PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
}
