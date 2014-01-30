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

PKG_NAME="libva"
PKG_VERSION="1.2.1"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://freedesktop.org/wiki/Software/vaapi"
PKG_URL="http://cgit.freedesktop.org/vaapi/libva/snapshot/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11 libXext libXfixes libdrm Mesa glu"
PKG_PRIORITY="optional"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libva: The main motivation for VAAPI (Video Acceleration API) is to enable hardware accelerated video decode/encode at various entry-points (VLD, IDCT, Motion Compensation etc.) for the prevailing coding standards today (MPEG-2, MPEG-4 ASP/H.263, MPEG-4 AVC/H.264, and VC-1/VMW3)."
PKG_LONGDESC="The main motivation for VAAPI (Video Acceleration API) is to enable hardware accelerated video decode/encode at various entry-points (VLD, IDCT, Motion Compensation etc.) for the prevailing coding standards today (MPEG-2, MPEG-4 ASP/H.263, MPEG-4 AVC/H.264, and VC-1/VMW3). Extending XvMC was considered, but due to its original design for MPEG-2 MotionComp only, it made more sense to design an interface from scratch that can fully expose the video decode capabilities in today's GPUs."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-docs \
                           --enable-drm \
                           --enable-x11 \
                           --enable-glx \
                           --disable-egl \
                           --disable-wayland \
                           --disable-dummy-driver \
                           --with-drivers-path=/usr/lib/va"

pre_configure_target() {
# todo: libva fails to build in subdirs
  cd $ROOT/$PKG_BUILD
  rm -rf .$TARGET_NAME
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  if [ "$DEVTOOLS" = yes ]; then
    mkdir -p $INSTALL/usr/bin
      cp test/vainfo/.libs/vainfo $INSTALL/usr/bin
  fi
}
