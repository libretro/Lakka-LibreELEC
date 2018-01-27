################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="minidlna"
PKG_VERSION="138d03d"
PKG_SHA256="efd780aa7c7e076dee273694b73d2f03598b0201ca79335b2975779c24469f97"
PKG_REV="100"
PKG_ARCH="any"
PKG_LICENSE="BSD-3c/GPLv2"
PKG_SITE="https://sourceforge.net/projects/minidlna/"
PKG_URL="http://repo.or.cz/minidlna.git/snapshot/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libiconv libid3tag libexif libjpeg-turbo libogg libvorbis ffmpeg flac sqlite"
PKG_SECTION="service"
PKG_SHORTDESC="MiniDLNA (ReadyMedia): a fully compliant DLNA/UPnP-AV server"
PKG_LONGDESC="MiniDLNA ($PKG_VERSION) (ReadyMedia) is a media server, with the aim of being fully compliant with DLNA/UPnP-AV clients."
PKG_TOOLCHAIN="autotools"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="MiniDLNA (ReadyMedia)"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --disable-nls \
                           --without-libiconv-prefix \
                           --without-libintl-prefix \
                           --with-os-name="$DISTRONAME" \
                           --with-db-path="/storage/.kodi/userdata/addon_data/service.minidlna/db" \
                           --with-os-url="https://libreelec.tv""

pre_configure_target() {
  export LDFLAGS="$LDFLAGS -L$(get_build_dir ffmpeg)/.install_pkg/usr/lib"
  export LIBS="$LIBS -lid3tag -lFLAC -logg -lz -lpthread -ldl -lm"
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -P $PKG_BUILD/.install_pkg/usr/sbin/minidlnad $ADDON_BUILD/$PKG_ADDON_ID/bin

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib
  cp -p $(get_build_dir libexif)/.install_pkg/usr/lib/libexif.so.12 $ADDON_BUILD/$PKG_ADDON_ID/lib
}
