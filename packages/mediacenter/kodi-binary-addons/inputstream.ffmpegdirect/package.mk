# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inputstream.ffmpegdirect"
PKG_VERSION="1.17.0-Matrix"
PKG_SHA256="0dde16a943e28e3c566a1245454886c8e59b69a43d9fb2cd79aede4c409a27dd"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL2+"
PKG_SITE="https://github.com/xbmc/inputstream.ffmpegdirect"
PKG_URL="https://github.com/xbmc/inputstream.ffmpegdirect/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform bzip2 ffmpeg gmp gnutls libpng libxml2 nettle xz zlib zvbi"
PKG_SECTION=""
PKG_SHORTDESC="inputstream.ffmpegdirect"
PKG_LONGDESC="InputStream Client for streams that can be opened by FFmpeg's libavformat such as plain TS, HLS and DASH (without DRM) streams."

PKG_IS_ADDON="yes"
