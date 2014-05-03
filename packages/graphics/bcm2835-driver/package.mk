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

PKG_NAME="bcm2835-driver"
PKG_VERSION="680ac93"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"
PKG_LONGDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$TARGET_FLOAT" = "softfp" -o "$TARGET_FLOAT" = "soft" ]; then
  FLOAT="softfp"
elif [ "$TARGET_FLOAT" = "hard" ]; then
  FLOAT="hardfp"
fi

make_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PRv $FLOAT/opt/vc/include/* $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libEGL.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libGLESv2.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libbcm_host.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvchiq_arm.so $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvcos.so $SYSROOT_PREFIX/usr/lib
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -PRv $FLOAT/opt/vc/sbin/vcfiled $INSTALL/usr/sbin

  mkdir -p $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libEGL.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libGLESv2.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libbcm_host.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libopenmaxil.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvchiq_arm.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/libvcos.so $INSTALL/usr/lib

# some usefull debug tools
  mkdir -p $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/vcdbg $INSTALL/usr/bin
      cp -PRv $FLOAT/opt/vc/lib/libdebug_sym.so $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/bin/vcgencmd $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/tvservice $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/edidparser $INSTALL/usr/bin

  mkdir -p $INSTALL/opt/vc
    ln -sf /usr/lib $INSTALL/opt/vc/lib
}

post_install() {
  enable_service fbset.service
  enable_service unbind-console.service
}
