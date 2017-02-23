################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-2017 Team LibreELEC
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

PKG_NAME="lcdd"
PKG_VERSION="c05a7de"
PKG_REV="102"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://lcdproc.org/"
PKG_URL="https://github.com/lcdproc/lcdproc/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="lcdproc-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain freetype libftdi1 libhid libugpio libusb netbsd-curses serdisplib"
PKG_SECTION="service"
PKG_SHORTDESC="LCDproc: Software to display system information from your Linux/*BSD box on a LCD"
PKG_LONGDESC="LCDproc ($PKG_VERSION) is a piece of software that displays real-time system information from your Linux/*BSD box on a LCD. The server supports several serial devices: Matrix Orbital, Crystal Fontz, Bayrad, LB216, LCDM001 (kernelconcepts.de), Wirz-SLI, Cwlinux(.com) and PIC-an-LCD; and some devices connected to the LPT port: HD44780, STV5730, T6963, SED1520 and SED1330. Various clients are available that display things like CPU load, system load, memory usage, uptime, and a lot more."
PKG_AUTORECONF="yes"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="LCDproc"
PKG_ADDON_TYPE="xbmc.service"

PKG_CONFIGURE_OPTS_TARGET="--with-ft-prefix=$SYSROOT_PREFIX/usr \
                           --enable-libusb \
                           --enable-libftdi \
                           --disable-libX11 \
                           --enable-libhid \
                           --disable-libpng \
                           --enable-drivers=all \
                           --enable-seamless-hbars"

pre_make_target() {
  # dont build parallel
    MAKEFLAGS=-j1
}

addon() {
  drivers="none|$(cat $PKG_BUILD/.$TARGET_NAME/config.log | sed -n "s|^DRIVERS=' \(.*\)'|\1|p" | sed "s|.so||g" | tr ' ' '|')"

  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/config

  cp -PR $PKG_DIR/resources $ADDON_BUILD/$PKG_ADDON_ID

  cp -PR $PKG_BUILD/.install_pkg/etc/LCDd.conf $ADDON_BUILD/$PKG_ADDON_ID/config/
  cp -PR $PKG_BUILD/.install_pkg/usr/lib       $ADDON_BUILD/$PKG_ADDON_ID/lib/
  cp -PR $PKG_BUILD/.install_pkg/usr/sbin      $ADDON_BUILD/$PKG_ADDON_ID/bin/

  cp -L $(get_build_dir serdisplib)/.install_pkg/usr/lib/libserdisp.so.1 $ADDON_BUILD/$PKG_ADDON_ID/lib/

  sed -e "s|^DriverPath=.*$|DriverPath=/storage/.kodi/addons/service.lcdd/lib/lcdproc/|" \
      -e "s|^#Foreground=.*$|Foreground=no|" \
      -e "s|^#ServerScreen=.*$|ServerScreen=blank|" \
      -e "s|^#Backlight=.*$|Backlight=open|" \
      -e "s|^#Heartbeat=.*$|Heartbeat=open|" \
      -e "s|^#TitleSpeed=.*$|TitleSpeed=4|" \
      -e "s|^#Hello=\"  Welcome to\"|Hello=\"Welcome to\"|" \
      -e "s|^#Hello=\"   LCDproc!\"|Hello=\"$DISTRONAME\"|" \
      -e "s|^#GoodBye=\"Thanks for using\"|GoodBye=\"Thanks for using\"|" \
      -e "s|^#GoodBye=\"   LCDproc!\"|GoodBye=\"$DISTRONAME\"|" \
      -e "s|^#normal_font=.*$|normal_font=/usr/share/fonts/liberation/LiberationMono-Bold.ttf|" \
      -i $ADDON_BUILD/$PKG_ADDON_ID/config/LCDd.conf

  sed -e "s/@DRIVERS@/$drivers/" \
      -i $ADDON_BUILD/$PKG_ADDON_ID/resources/settings.xml

}
