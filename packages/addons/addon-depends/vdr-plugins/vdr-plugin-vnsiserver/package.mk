# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-vnsiserver"
PKG_VERSION="49003f036609ee2a0b8d819979c063d8f8d348c8"
PKG_SHA256="fc64c343685bf87e4cc14018bcf642cba9aa637adfe1ab21725a19945c620737"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FernetMenta/vdr-plugin-vnsiserver"
PKG_URL="https://github.com/FernetMenta/vdr-plugin-vnsiserver/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="VDR plugin to handle Kodi clients."
PKG_TOOLCHAIN="manual"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=$VDR_DIR:$PKG_CONFIG_PATH
  export CPLUS_INCLUDE_PATH=$VDR_DIR/include

  make \
    LIBDIR="." \
    LOCDIR="./locale" \
    all install-i18n
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=`sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' $VDR_DIR/config.h`
  LIB_NAME=lib${PKG_NAME/-plugin/}

  cp --remove-destination $PKG_BUILD/${LIB_NAME}.so $PKG_BUILD/${LIB_NAME}.so.${VDR_APIVERSION}
}
