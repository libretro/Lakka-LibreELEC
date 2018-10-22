# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screen"
PKG_VERSION="4.6.2"
PKG_SHA256="1b6922520e6a0ce5e28768d620b0f640a6631397f95ccb043b70b91bb503fa3a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/screen/"
PKG_URL="http://ftpmirror.gnu.org/screen/$PKG_NAME-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
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
