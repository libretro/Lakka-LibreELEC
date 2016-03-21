################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="tvheadend"
PKG_VERSION="7f3fb87"
PKG_VERSION_NUMBER="4.0.9"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvheadend.org"
PKG_URL="https://github.com/tvheadend/tvheadend/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain curl libdvbcsa libressl Python:host"
PKG_PRIORITY="optional"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="Tvheadend (Version: $PKG_VERSION_NUMBER): is a TV streaming server for Linux."
PKG_LONGDESC="Tvheadend (Version: $PKG_VERSION_NUMBER): is a TV streaming server for Linux supporting DVB-S, DVB-S2, DVB-C, DVB-T, ATSC, IPTV,SAT>IP."

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Tvheadend"
PKG_ADDON_TYPE="xbmc.service"
PKG_AUTORECONF="no"
PKG_ADDON_REPOVERSION="7.0"

post_unpack() {
  sed -e 's/VER="0.0.0~unknown"/VER="'$PKG_VERSION_NUMBER' ~ LibreELEC Tvh-addon v'$PKG_ADDON_REPOVERSION'.'$PKG_REV'"/g' -i $PKG_BUILD/support/version
}

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
  export CROSS_COMPILE=$TARGET_PREFIX
}

configure_target() {
  ./configure --prefix=/usr \
            --arch=$TARGET_ARCH \
            --cpu=$TARGET_CPU \
            --cc=$TARGET_CC \
            --enable-hdhomerun_client \
            --enable-hdhomerun_static \
            --disable-avahi \
            --disable-libav \
            --enable-inotify \
            --enable-epoll \
            --disable-uriparser \
            --enable-tvhcsa \
            --enable-bundle \
            --enable-dvbcsa \
            --disable-dbus_1 \
            --python=$ROOT/$TOOLCHAIN/bin/python
}

post_make_target() {
  $CC -O -fbuiltin -fomit-frame-pointer -fPIC -shared -o capmt_ca.so src/extra/capmt_ca.c -ldl
}

makeinstall_target() {
  : # nothing to do here
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/build.linux/tvheadend $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.$TARGET_NAME/capmt_ca.so $ADDON_BUILD/$PKG_ADDON_ID/bin
}
