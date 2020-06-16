# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="inputstream.ffmpegdirect"
PKG_VERSION="1.14.0-Matrix"
PKG_SHA256="640fb4d24b5b23368c2cdab0d3302abdd95c302ec3312cbf01befa5be131788e"
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
