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

PKG_NAME="libdrm"
PKG_VERSION="2.4.64"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://dri.freedesktop.org"
PKG_URL="http://dri.freedesktop.org/libdrm/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libpthread-stubs libpciaccess"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="libdrm: Userspace interface to kernel DRM services"
PKG_LONGDESC="The userspace interface library to kernel DRM services."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

get_graphicdrivers

DRM_CONFIG="--disable-libkms --disable-intel --disable-radeon"
DRM_CONFIG="$DRM_CONFIG --disable-nouveau --disable-vmwgfx"

for drv in $GRAPHIC_DRIVERS; do
  [ "$drv" = "i915" -o "$drv" = "i965" ] && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-libkms/enable-libkms/'` && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-intel/enable-intel/'`

  [ "$drv" = "r200" -o "$drv" = "r300" -o "$drv" = "r600" -o "$drv" = "radeonsi" ] && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-libkms/enable-libkms/'` && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-radeon/enable-radeon/'`
done

PKG_CONFIGURE_OPTS_TARGET="--disable-udev \
                           --enable-largefile \
                           --with-kernel-source=$(kernel_path) \
                           $DRM_CONFIG \
                           --disable-install-test-programs \
                           --disable-cairo-tests \
                           --disable-manpages \
                           --disable-valgrind"
