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

PKG_NAME="shairport-sync"
PKG_VERSION="3.1.7"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/mikebrady/shairport-sync"
PKG_URL="https://github.com/mikebrady/shairport-sync/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib avahi libconfig libdaemon openssl popt pulseaudio soxr"
PKG_SECTION="tools"
PKG_LONGDESC="AirPlay audio player"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-alsa \
                           --with-avahi \
                           --with-convolution \
                           --with-metadata \
                           --with-pa \
                           --with-pipe \
                           --with-soxr \
                           --with-ssl=openssl \
                           --with-stdout"

makeinstall_target() {
  :
}
