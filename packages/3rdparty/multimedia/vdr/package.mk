################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="vdr"
PKG_VERSION="2.1.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvdr.de"
PKG_URL="ftp://ftp.tvdr.de/vdr/Developer/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain fontconfig freetype libcap libjpeg-turbo bzip2"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr: A powerful DVB TV application"
PKG_LONGDESC="This project describes how to build your own digital satellite receiver and video disk recorder. It is based mainly on the DVB-S digital satellite receiver card, which used to be available from Fujitsu Siemens and the driver software developed by the LinuxTV project."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_unpack() {
  rm -rf $PKG_BUILD/PLUGINS/src/skincurses
}

pre_configure_target() {
  export LDFLAGS=$(echo $LDFLAGS | sed -e "s|-Wl,--as-needed||")
}

pre_make_target() {
  cat > Make.config <<EOF
  PLUGINLIBDIR = /usr/lib/vdr
  PREFIX = /usr
  VIDEODIR = /storage/videos
  CONFDIR = /storage/.config/vdr
  LOCDIR = /usr/share/locale

  NO_KBD=yes
  VDR_USER=root
EOF
}

make_target() {
  make vdr
  make include-dir
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}
