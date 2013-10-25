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

PKG_NAME="vdr-wirbelscancontrol"
PKG_VERSION="0.0.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://wirbel.htpc-forum.de/wirbelscancontrol/index2.html"
PKG_URL="http://wirbel.htpc-forum.de/wirbelscancontrol/$PKG_NAME-$PKG_VERSION.tgz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain vdr vdr-wirbelscan"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="TV"
PKG_LONGDESC="TV"

PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

VDR_DIR=$(basename $BUILD/vdr-[0-9]*)
PKG_MAKE_OPTS_TARGET="VDRDIR=$ROOT/$BUILD/$VDR_DIR \
                      LIBDIR=\".\" \
                      LOCALEDIR=\"./locale\""

post_unpack() {
  mv $ROOT/$BUILD/wirbelscancontrol-${PKG_VERSION} $ROOT/$BUILD/${PKG_NAME}-${PKG_VERSION}
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

pre_build_target() {
  ln -sf $ROOT/$BUILD/vdr-wirbelscan-[0-9]*/wirbelscan_services.h $PKG_BUILD
}

makeinstall_target() {
  : # installation not needed, done by create-addon script
}
