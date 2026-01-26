# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vdr"
PKG_VERSION="2.7.8"
PKG_SHA256="c1417b486b99356856764ad51d67d7ae157dd7d82398487f9776269c99973c88"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvdr.de"
PKG_URL="https://github.com/vdr-projects/vdr/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain bzip2 fontconfig freetype libcap libiconv libjpeg-turbo"
PKG_LONGDESC="A DVB TV server application."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -rf ${PKG_BUILD}/PLUGINS/src/skincurses
}

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/lib/iconv"
}

pre_make_target() {
  cat >Make.config <<EOF
  PLUGINLIBDIR = /usr/lib/vdr
  PREFIX = /usr
  VIDEODIR = /storage/videos
  CONFDIR = /storage/.config/vdr
  LOCDIR = ./locale
  LIBS += -liconv
  NO_KBD=yes
  VDR_USER=root
EOF
}

make_target() {
  make vdr vdr.pc
  make LOCDIR=./dummylocale install-i18n
  make include-dir
}
