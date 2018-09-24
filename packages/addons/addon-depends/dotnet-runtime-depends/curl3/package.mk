# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

. $(get_pkg_directory curl)/package.mk

PKG_NAME="curl3"
PKG_URL=""
PKG_LONGDESC="curl for dotnet"

unpack() {
  mkdir -p $PKG_BUILD
  cp -r $(get_build_dir curl)/* $PKG_BUILD
  sed -i 's/CURL_@CURL_LT_SHLIB_VERSIONED_FLAVOUR@4/CURL_@CURL_LT_SHLIB_VERSIONED_FLAVOUR@3/g' $PKG_BUILD/lib/libcurl.vers.in
}

makeinstall_target() {
  make install DESTDIR=$INSTALL $PKG_MAKEINSTALL_OPTS_TARGET
}

post_makeinstall_target() {
  :
}
