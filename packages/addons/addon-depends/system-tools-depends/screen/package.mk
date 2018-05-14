################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="screen"
PKG_VERSION="4.6.2"
PKG_SHA256="1b6922520e6a0ce5e28768d620b0f640a6631397f95ccb043b70b91bb503fa3a"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/screen/"
PKG_URL="http://ftpmirror.gnu.org/screen/$PKG_NAME-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_SECTION="shell/console"
PKG_LONGDESC="Screen is a window manager that multiplexes a physical terminal between several processes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_header_utempter_h=no \
                           --enable-colors256 \
                           --disable-pam \
                           --disable-use-locale \
                           --disable-telnet \
                           --disable-socket-dir"

pre_configure_target() {
  CFLAGS="$CFLAGS -DTERMINFO"
  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`

# screen fails to build in subdirs
  cd $PKG_BUILD
    rm -rf .$TARGET_NAME
}

makeinstall_target() {
  :
}
