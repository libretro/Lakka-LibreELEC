# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-epgfixer"
PKG_VERSION="9bbf438eb031ef377ca2b8e08376be9368a8df0f"
PKG_SHA256="c0be61b7540c660c0cffa9b8096ce1890b84f8e0648a25ba081855dd2259f97b"
PKG_LICENSE="GPL"
PKG_SITE="http://projects.vdr-developer.org/projects/plg-epgfixer"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-epgfixer/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr pcre2"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="Plugin for modifying EPG data using regular expressions."
PKG_TOOLCHAIN="manual"

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  make \
    LIBDIR="." \
    LOCDIR="./locale" \
    all install-i18n
}

post_make_target() {
  VDR_DIR=$(get_build_dir vdr)
  VDR_APIVERSION=$(sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' ${VDR_DIR}/config.h)
  LIB_NAME=lib${PKG_NAME/-plugin/}

  cp --remove-destination ${PKG_BUILD}/${LIB_NAME}.so ${PKG_BUILD}/${LIB_NAME}.so.${VDR_APIVERSION}
}
