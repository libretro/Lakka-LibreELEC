################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vdr"
PKG_VERSION="2.4.0"
PKG_SHA256="93af49fe87048073dc38ef5e6c71e9704344d730f21c261afac69e3c937f8cce"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvdr.de"
PKG_URL="ftp://ftp.tvdr.de/vdr/vdr-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain bzip2 fontconfig freetype libcap libiconv libjpeg-turbo"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr: A powerful DVB TV application"
PKG_LONGDESC="This project describes how to build your own digital satellite receiver and video disk recorder. It is based mainly on the DVB-S digital satellite receiver card, which used to be available from Fujitsu Siemens and the driver software developed by the LinuxTV project."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -rf $PKG_BUILD/PLUGINS/src/skincurses
}

pre_configure_target() {
  export LDFLAGS="$(echo $LDFLAGS | sed -e "s|-Wl,--as-needed||") -L$SYSROOT_PREFIX/usr/lib/iconv"
}

pre_make_target() {
  cat > Make.config <<EOF
  PLUGINLIBDIR = /usr/lib/vdr
  PREFIX = /usr
  VIDEODIR = /storage/videos
  CONFDIR = /storage/.config/vdr
  LOCDIR = /usr/share/locale
  LIBS += -liconv
  NO_KBD=yes
  VDR_USER=root
EOF
}

make_target() {
  make vdr vdr.pc
  make include-dir
}
