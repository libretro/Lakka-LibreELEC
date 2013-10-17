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

PKG_NAME="bluez"
PKG_VERSION="5.10"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.bluez.org/"
PKG_URL="http://www.kernel.org/pub/linux/bluetooth/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS="libusb-compat dbus glib systemd"
PKG_BUILD_DEPENDS_TARGET="toolchain libusb-compat dbus glib readline systemd"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="bluez: Bluetooth Tools and System Daemons for Linux."
PKG_LONGDESC="Bluetooth Tools and System Daemons for Linux."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$DEBUG" = "yes" ]; then
  BLUEZ_CONFIG="--enable-debug"
else
  BLUEZ_CONFIG="--disable-debug"
fi

if [ "$DEVTOOLS" = "yes" ]; then
  BLUEZ_CONFIG="$BLUEZ_CONFIG --enable-monitor --enable-test"
else
  BLUEZ_CONFIG="$BLUEZ_CONFIG --disable-monitor --disable-test"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-dependency-tracking \
                           --disable-silent-rules \
                           --enable-library \
                           --enable-usb \
                           --enable-udev \
                           --disable-cups \
                           --disable-obex \
                           --enable-client \
                           --enable-systemd \
                           --enable-tools \
                           --enable-datafiles \
                           --disable-experimental \
                           --enable-playstation-peripheral \
                           --with-gnu-ld \
                           $BLUEZ_CONFIG \
                           storagedir=/storage/.cache/bluetooth"

pre_configure_target() {
# bluez fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME
}

post_makeinstall_target() {
  rm -rf $INSTALL/lib/systemd
}

post_install() {
  enable_service bluetooth.service
  enable_service obex.service
}

