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

PKG_NAME="libcec"
PKG_VERSION="2.1.4"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libcec.pulse-eight.com/"
PKG_URL="http://packages.pulse-eight.net/pulse/sources/libcec/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd lockdev"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="libCEC is an open-source dual licensed library designed for communicating with the Pulse-Eight USB - CEC Adaptor"
PKG_LONGDESC="libCEC is an open-source dual licensed library designed for communicating with the Pulse-Eight USB - CEC Adaptor."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-cubox"

if [ "$XBMCPLAYER_DRIVER" = "bcm2835-driver" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bcm2835-driver"

  export CFLAGS="$CFLAGS \
                 -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
                 -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
  export CXXFLAGS="$CXXFLAGS \
                   -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
                   -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"

  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-rpi \
                             --with-rpi-include-path=$SYSROOT_PREFIX/usr/include \
                             --with-rpi-lib-path=$SYSROOT_PREFIX/usr/lib"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-rpi"
fi

if [ "$XBMCPLAYER_DRIVER" = "libfslvpuwrap" ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-imx6"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-imx6"
fi


# dont use some optimizations because of build problems
  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`
