# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr-plugin-live"
PKG_VERSION="b2938deb061a83454d14aeb149c18a87e38e8b25"
PKG_SHA256="f74844fad4f0c3fd828816fd3f094ff740d82d31a164b0cd6384aff9fb7e33b8"
PKG_LICENSE="GPL"
PKG_SITE="http://live.vdr-developer.org/en/index.php"
PKG_URL="https://github.com/MarkusEh/vdr-plugin-live/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vdr tntnet pcre:host pcre"
PKG_NEED_UNPACK="$(get_pkg_directory vdr)"
PKG_LONGDESC="Allows a comfortable operation of VDR and some of its plugins trough a web interface."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic -parallel"

pre_configure_target() {
  export LDFLAGS="${LDFLAGS} -L${SYSROOT_PREFIX}/usr/lib/iconv"
}

make_target() {
  VDR_DIR=$(get_build_dir vdr)
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include
  VDR_APIVERSION=$(sed -ne '/define APIVERSION/s/^.*"\(.*\)".*$/\1/p' ${VDR_DIR}/config.h)
  LIB_NAME=lib${PKG_NAME/-plugin/}

  make VDRDIR=${VDR_DIR} \
    LIBDIR="." \
    LOCALEDIR="./locale" \
    all install-i18n

  cp --remove-destination ${PKG_BUILD}/${LIB_NAME}.so ${PKG_BUILD}/${LIB_NAME}.so.${VDR_APIVERSION}
}
