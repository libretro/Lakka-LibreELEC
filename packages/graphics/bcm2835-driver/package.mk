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

PKG_NAME="bcm2835-driver"
PKG_VERSION="469fc79"
PKG_SHA256="235ce3c4903323cb61207d3e1eaab4f0c35e845eab99fd35841ce55035e8d80e"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain dtc"
PKG_SECTION="graphics"
PKG_SHORTDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"
PKG_LONGDESC="OpenMAX-bcm2835: OpenGL-ES and OpenMAX driver for BCM2835"
PKG_TOOLCHAIN="manual"

if [ "$TARGET_FLOAT" = "softfp" -o "$TARGET_FLOAT" = "soft" ]; then
  FLOAT="softfp"
elif [ "$TARGET_FLOAT" = "hard" ]; then
  FLOAT="hardfp"
fi

make_target() {
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -PRv $FLOAT/opt/vc/include/* $SYSROOT_PREFIX/usr/include

  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/*.so $SYSROOT_PREFIX/usr/lib
    ln -sf $SYSROOT_PREFIX/usr/lib/libbrcmEGL.so $SYSROOT_PREFIX/usr/lib/libEGL.so
    ln -sf $SYSROOT_PREFIX/usr/lib/libbrcmGLESv2.so $SYSROOT_PREFIX/usr/lib/libGLESv2.so
    cp -PRv $FLOAT/opt/vc/lib/*.a $SYSROOT_PREFIX/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/pkgconfig $SYSROOT_PREFIX/usr/lib
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -PRv $FLOAT/opt/vc/sbin/vcfiled $INSTALL/usr/sbin

  mkdir -p $INSTALL/usr/lib
    cp -PRv $FLOAT/opt/vc/lib/*.so $INSTALL/usr/lib
    ln -sf /usr/lib/libbrcmEGL.so $INSTALL/usr/lib/libEGL.so
    ln -sf /usr/lib/libbrcmEGL.so $INSTALL/usr/lib/libEGL.so.1
    ln -sf /usr/lib/libbrcmGLESv2.so $INSTALL/usr/lib/libGLESv2.so
    ln -sf /usr/lib/libbrcmGLESv2.so $INSTALL/usr/lib/libGLESv2.so.2

# some usefull debug tools
  mkdir -p $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/dtoverlay $INSTALL/usr/bin
    ln -s dtoverlay $INSTALL/usr/bin/dtparam
    cp -PRv $FLOAT/opt/vc/bin/vcdbg $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/vcgencmd $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/tvservice $INSTALL/usr/bin
    cp -PRv $FLOAT/opt/vc/bin/edidparser $INSTALL/usr/bin

  mkdir -p $INSTALL/opt/vc
    ln -sf /usr/lib $INSTALL/opt/vc/lib
}

post_install() {
  enable_service unbind-console.service
}
