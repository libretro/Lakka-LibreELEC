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

PKG_NAME="libcec"
PKG_VERSION="209884d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libcec.pulse-eight.com/"
PKG_URL="https://github.com/Pulse-Eight/libcec/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd lockdev p8-platform"
PKG_SECTION="system"
PKG_SHORTDESC="libCEC is an open-source dual licensed library designed for communicating with the Pulse-Eight USB - CEC Adaptor"
PKG_LONGDESC="libCEC is an open-source dual licensed library designed for communicating with the Pulse-Eight USB - CEC Adaptor."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=1 \
                       -DCMAKE_INSTALL_LIBDIR=/usr/lib \
                       -DCMAKE_INSTALL_LIBDIR_NOARCH=/usr/lib \
                       -DCMAKE_INSTALL_PREFIX_TOOLCHAIN=$SYSROOT_PREFIX/usr \
                       -DCMAKE_PREFIX_PATH=$SYSROOT_PREFIX/usr"

if [ "$KODIPLAYER_DRIVER" = "bcm2835-firmware" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET bcm2835-firmware"
fi

if [ "$KODIPLAYER_DRIVER" = "libfslvpuwrap" ]; then
  PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_IMX_API=1"
else
  PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_IMX_API=0"
fi

if [ "$KODIPLAYER_DRIVER" = "libamcodec" ]; then
  if [ "$TARGET_ARCH" = "aarch64" ]; then
    PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_AOCEC_API=1"
  else
    PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_AMLOGIC_API=1"
  fi
else
  PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_TARGET -DHAVE_AOCEC_API=0 -DHAVE_AMLOGIC_API=0"
fi

pre_configure_target() {
  if [ "$KODIPLAYER_DRIVER" = "bcm2835-firmware" ]; then
    export CXXFLAGS="$CXXFLAGS \
      -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"

    # detecting RPi support fails without -lvchiq_arm
    export LDFLAGS="$LDFLAGS -lvchiq_arm"
  fi
}

post_makeinstall_target() {
  if [ -d $INSTALL/usr/lib/python2.7/dist-packages ]; then 
    mv $INSTALL/usr/lib/python2.7/dist-packages $INSTALL/usr/lib/python2.7/site-packages
  fi
}
