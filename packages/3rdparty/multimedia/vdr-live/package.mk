################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="vdr-live"
PKG_VERSION="0.3.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://live.vdr-developer.org/en/index.php"
PKG_URL="http://live.vdr-developer.org/downloads/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain vdr tntnet pcre-host pcre"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="vdr-live: the LIVE Interactive VDR Environment/"
PKG_LONGDESC="vdr-live allows a comfortable operation of VDR and some of its plugins trough a web interface"

PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

VDR_DIR=$(basename $BUILD/vdr-[0-9]*)
PKG_MAKE_OPTS_TARGET="VDRDIR=$ROOT/$BUILD/$VDR_DIR \
                      LIBDIR=\".\" \
                      LOCALEDIR=\"./locale\""

post_unpack() {
  mv $ROOT/$BUILD/live-${PKG_VERSION} $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC -L$SYSROOT_PREFIX/usr/lib -L$SYSROOT_PREFIX/lib"
  export CXXFLAGS="$CXXFLAGS -fPIC -L$SYSROOT_PREFIX/usr/lib -L$SYSROOT_PREFIX/lib"
  export LDFLAGS="$LDFLAGS -fPIC -L$SYSROOT_PREFIX/usr/lib -L$SYSROOT_PREFIX/lib"
}

pre_make_target() {
  # dont build parallel
  MAKEFLAGS=-j1
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}
