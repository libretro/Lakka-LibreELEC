################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="lirc"
PKG_VERSION="0.9.4c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.lirc.org"
PKG_URL="https://sourceforge.net/projects/lirc/files/LIRC/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libftdi1 libusb-compat libxslt"
PKG_SECTION="sysutils/remote"
PKG_SHORTDESC="lirc: Linux Infrared Remote Control"
PKG_LONGDESC="LIRC is a package that allows you to decode and send infra-red signals of many (but not all) commonly used remote controls."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_forkpty=no \
                           ac_cv_lib_util_forkpty=no \
                           ac_cv_prog_HAVE_PYTHON3=no \
                           --localstatedir=/ \
                           --with-gnu-ld \
                           --without-x"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/systemd
  rm -rf $INSTALL/lib
  rm -rf $INSTALL/usr/share
  rm -rf $INSTALL/etc

  mkdir -p $INSTALL/etc/lirc
    cp $PKG_DIR/config/lircd.conf.* $INSTALL/etc/lirc

  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/lircd_helper $INSTALL/usr/lib/libreelec

  mkdir -p $INSTALL/usr/lib/udev
    cp $PKG_DIR/scripts/lircd_wakeup_enable $INSTALL/usr/lib/udev

  mkdir -p $INSTALL/usr/share/services
    cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services
}
