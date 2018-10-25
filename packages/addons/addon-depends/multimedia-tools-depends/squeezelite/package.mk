# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="squeezelite"
PKG_VERSION="ecb6e3696a42113994640e5345d0b5ca2e77d28b"
PKG_SHA256="b0fbded72fbf400613b5cb071bc0efdaddaeba6b4ba32b1de9b24098c505b40b"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/ralph-irving/squeezelite"
PKG_URL="https://github.com/ralph-irving/squeezelite/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain faad2 ffmpeg flac libmad libvorbis mpg123 soxr libogg"
PKG_LONGDESC="A client for the Logitech Media Server."

pre_make_target() {
  export OPTS="-DDSD -DFFMPEG -DRESAMPLE -DVISEXPORT -DLINKALL"
  export LIBS="-lvorbis -logg"
}

makeinstall_target() {
  :
}
