# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="squeezelite"
PKG_VERSION="b2ed99e"
PKG_SHA256="9773543d6565481c519fb73d42d59a25a2940bfbb39b48ce81054cd9dd24e2a9"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/ralph-irving/squeezelite"
PKG_URL="https://github.com/ralph-irving/squeezelite/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain faad2 ffmpeg flac libmad libvorbis mpg123 soxr libogg"
PKG_SECTION="tools"
PKG_LONGDESC="A client for the Logitech Media Server"

makeinstall_target() {
  :
}
