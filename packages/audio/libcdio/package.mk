################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="libcdio"
PKG_VERSION="0.93"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/libcdio/"
PKG_URL="https://ftp.gnu.org/gnu/libcdio/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="libcdio: A CD-ROM reading and control library"
PKG_LONGDESC="This library is to encapsulate CD-ROM reading and control. Applications wishing to be oblivious of the OS- and device-dependant properties of a CD-ROM can use this library. Some support for disk image types like BIN/CUE and NRG is available, so applications that use this library also have the ability to read disc images as though they were CD's."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--enable-cxx \
                           --disable-cpp-progs \
                           --disable-shared \
                           --enable-static \
                           --enable-joliet \
                           --disable-rpath \
                           --enable-rock \
                           --disable-cddb \
                           --disable-vcd-info \
                           --without-cd-drive \
                           --without-cd-info \
                           --without-cdda-player \
                           --without-cd-read \
                           --without-iso-info \
                           --without-iso-read \
                           --without-libiconv-prefix \
                           --with-gnu-ld"

pre_configure_target() {
  CFLAGS="$CFLAGS -fPIC -DPIC"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
