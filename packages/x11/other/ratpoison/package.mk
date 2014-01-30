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

PKG_NAME="ratpoison"
PKG_VERSION="1.4.6"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.nongnu.org/ratpoison"
PKG_URL="http://download.savannah.nongnu.org/releases/ratpoison/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros libICE libX11 libXext libXtst libXinerama"
PKG_PRIORITY="optional"
PKG_SECTION="x11/other"
PKG_SHORTDESC="ratpoison: A window manager that lets you say good-bye to the rodent"
PKG_LONGDESC="Ratpoison is a simple window manager with no large library dependencies, no fancy graphics, no window decorations, and no rodent dependence. It is largely modeled after GNU Screen, which has done wonders in the virtual terminal market. All interaction with the window manager is done through keystrokes. Ratpoison has a prefix map to minimize the key clobbering that cripples EMACS and other quality pieces of software. All windows are maximized and kept maximized to avoid wasting precious screen space."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--x-includes=$SYSROOT_PREFIX/usr/include \
                           --x-libraries=$SYSROOT_PREFIX/usr/lib \
                           --disable-debug \
                           --disable-history \
                           --with-xterm=rxvt \
                           --without-xft \
                           --with-x"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -fwhole-program"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/rpws
  rm -rf $INSTALL/usr/share

  mkdir -p $INSTALL/etc
    cp $PKG_DIR/config/ratpoisonrc $INSTALL/etc
}
