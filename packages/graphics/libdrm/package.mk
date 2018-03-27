
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

PKG_NAME="libdrm"
PKG_VERSION="2.4.91"
PKG_SHA256="634a0ed0cc1eff06f48674b1da81aafa661a9f001e7a4f43dde81076886dc800"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://dri.freedesktop.org"
PKG_URL="http://dri.freedesktop.org/libdrm/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libpciaccess"
PKG_SECTION="graphics"
PKG_SHORTDESC="libdrm: Userspace interface to kernel DRM services"
PKG_LONGDESC="The userspace interface library to kernel DRM services."
PKG_TOOLCHAIN="autotools"

get_graphicdrivers

DRM_CONFIG="--disable-intel --disable-radeon --disable-amdgpu"
DRM_CONFIG="$DRM_CONFIG --disable-nouveau --disable-vmwgfx --disable-vc4"

for drv in $GRAPHIC_DRIVERS; do
  [ "$drv" = "i915" -o "$drv" = "i965" ] && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-intel/enable-intel/'`

  [ "$drv" = "r200" -o "$drv" = "r300" -o "$drv" = "r600" -o "$drv" = "radeonsi" ] && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-radeon/enable-radeon/'` && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-amdgpu/enable-amdgpu/'`

  [ "$drv" = "vmware" ] && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-vmwgfx/enable-vmwgfx/'`

  [ "$drv" = "vc4" ] && \
    DRM_CONFIG=`echo $DRM_CONFIG | sed -e 's/disable-vc4/enable-vc4/'`
done

PKG_CONFIGURE_OPTS_TARGET="--disable-udev \
                           --enable-largefile \
                           --with-kernel-source=$(kernel_path) \
                           --disable-libkms \
                           $DRM_CONFIG \
                           --disable-nouveau \
                           --disable-freedreno \
                           --disable-install-test-programs \
                           --disable-cairo-tests \
                           --disable-manpages \
                           --disable-valgrind"
