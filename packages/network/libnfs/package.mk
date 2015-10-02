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

PKG_NAME="libnfs"
PKG_VERSION="1.9.8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/sahlberg/libnfs"
PKG_URL="https://sites.google.com/site/libnfstarballs/li/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="libnfs: a client library for accessing NFS shares over a network."
PKG_LONGDESC="LIBNFS is a client library for accessing NFS shares over a network."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-examples --disable-tirpc"

pre_configure_target() {
# dont build parallel
  MAKEFLAGS=-j1

  export CFLAGS="$CFLAGS -D_FILE_OFFSET_BITS=64 -I$ROOT/$PKG_BUILD/mount -I$ROOT/$PKG_BUILD/nfs"
}
