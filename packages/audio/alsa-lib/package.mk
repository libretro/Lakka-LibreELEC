################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="alsa-lib"
PKG_VERSION="1.1.6"
PKG_SHA256="5f2cd274b272cae0d0d111e8a9e363f08783329157e8dd68b3de0c096de6d724"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/lib/alsa-lib-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="audio"
PKG_LONGDESC="ALSA (Advanced Linux Sound Architecture) is the next generation Linux Sound API."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-lto +pic"

if build_with_debug; then
  PKG_ALSA_DEBUG=--with-debug
else
  PKG_ALSA_DEBUG=--without-debug
fi

PKG_CONFIGURE_OPTS_TARGET="$PKG_ALSA_DEBUG \
                           --disable-dependency-tracking \
                           --with-plugindir=/usr/lib/alsa \
                           --disable-python"

post_configure_target() {
  sed -i 's/.*PKGLIBDIR.*/#define PKGLIBDIR ""/' include/config.h
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/config
    cp -PR $PKG_DIR/config/modprobe.d $INSTALL/usr/config
}

post_install() {
  add_group audio 63
}
