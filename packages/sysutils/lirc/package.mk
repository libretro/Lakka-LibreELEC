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
PKG_VERSION="0.10.0"
PKG_SHA256="e57c2de8b1b91325d23f1c14fc553ec7912b0add7891e653d048300d38c3f553"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.lirc.org"
PKG_URL="https://sourceforge.net/projects/lirc/files/LIRC/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libftdi1 libusb-compat libxslt"
PKG_SECTION="sysutils/remote"
PKG_SHORTDESC="lirc: Linux Infrared Remote Control"
PKG_LONGDESC="LIRC is a package that allows you to decode and send infra-red signals of many (but not all) commonly used remote controls."
PKG_TOOLCHAIN="autotools"

PKG_PYTHON_WANTED=Python2

PKG_CONFIGURE_OPTS_TARGET="--enable-devinput \
                           --with-gnu-ld \
                           --without-x"

pre_configure_target() {
  export HAVE_WORKING_POLL=yes
  export HAVE_UINPUT=yes
  export PYTHON=:
  export PYTHON_VERSION=${PKG_PYTHON_VERSION#python}
  if [ -e ${SYSROOT_PREFIX}/usr/include/linux/input-event-codes.h ] ; then
    export DEVINPUT_HEADER=${SYSROOT_PREFIX}/usr/include/linux/input-event-codes.h
  else
    export DEVINPUT_HEADER=${SYSROOT_PREFIX}/usr/include/linux/input.h
  fi
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/lib/systemd
  rm -rf $INSTALL/lib
  rm -rf $INSTALL/usr/share
  rm -rf $INSTALL/etc

  mkdir -p $INSTALL/etc/lirc
    cp -r $PKG_DIR/config/lirc_options.conf $INSTALL/etc/lirc
    ln -s /storage/.config/lircd.conf $INSTALL/etc/lirc/lircd.conf

  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/lircd_helper $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/lircd_uinput_helper $INSTALL/usr/lib/libreelec

  mkdir -p $INSTALL/usr/share/services
    cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services
}

post_install() {
  enable_service lircd.socket
  enable_service lircd.service
  enable_service lircd-uinput.service
}
