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

PKG_NAME="xf86-video-nvidia"
PKG_VERSION="340.24"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.nvidia.com/"
[ "$TARGET_ARCH" = "i386" ] && PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86/$PKG_VERSION/NVIDIA-Linux-x86-$PKG_VERSION.run"
[ "$TARGET_ARCH" = "x86_64" ] && PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/$PKG_VERSION/NVIDIA-Linux-x86_64-$PKG_VERSION-no-compat32.run"
PKG_DEPENDS_TARGET="toolchain util-macros linux xorg-server"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-nvidia: The Xorg driver for NVIDIA video chips"
PKG_LONGDESC="These binary drivers provide optimized hardware acceleration of OpenGL applications via a direct-rendering X Server. AGP, PCIe, SLI, TV-out and flat panel displays are also supported. This version only supports GeForce 8xxx and higher of the Geforce GPUs plus complimentary Quadros and nforce."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$VDPAU" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET libvdpau"
fi

unpack() {
  NV_PKG="`echo $PKG_URL | sed 's%.*/\(.*\)$%\1%'`"
  [ -d $PKG_BUILD ] && rm -rf $PKG_BUILD

  sh $SOURCES/$PKG_NAME/$NV_PKG --extract-only --target $BUILD/$PKG_NAME-$PKG_VERSION
}

make_target() {
  unset LDFLAGS

  cd kernel
    make module CC=$CC SYSSRC=$(kernel_path) SYSOUT=$(kernel_path)
  cd ..
}

makeinstall_target() {
  mkdir -p $INSTALL/$XORG_PATH_MODULES/drivers
    cp -P nvidia_drv.so $INSTALL/$XORG_PATH_MODULES/drivers

  mkdir -p $INSTALL/$XORG_PATH_MODULES/extensions
  # rename to not conflicting with Mesa libGL.so
    cp -P libglx.so* $INSTALL/$XORG_PATH_MODULES/extensions/libglx_nvidia.so

  mkdir -p $INSTALL/etc/X11
    cp $PKG_DIR/config/*.conf $INSTALL/etc/X11

  mkdir -p $INSTALL/usr/lib
    cp -P libnvidia-glcore.so.$PKG_VERSION $INSTALL/usr/lib
    cp -P libnvidia-ml.so.$PKG_VERSION $INSTALL/usr/lib
      ln -sf libnvidia-ml.so.$PKG_VERSION $INSTALL/usr/lib/libnvidia-ml.so.1
    cp -P tls/libnvidia-tls.so.$PKG_VERSION $INSTALL/usr/lib
  # rename to not conflicting with Mesa libGL.so
    cp -P libGL.so* $INSTALL/usr/lib/libGL_nvidia.so.1

  mkdir -p $INSTALL/lib/modules/$(get_module_dir)/nvidia
    cp kernel/nvidia.ko $INSTALL/lib/modules/$(get_module_dir)/nvidia

  mkdir -p $INSTALL/usr/bin
    cp nvidia-smi $INSTALL/usr/bin

  if [ "$VDPAU" = yes ]; then
    mkdir -p $INSTALL/usr/lib/vdpau
      cp libvdpau_nvidia.so* $INSTALL/usr/lib/vdpau/libvdpau_nvidia.so.1
      ln -sf libvdpau_nvidia.so.1 $INSTALL/usr/lib/vdpau/libvdpau_nvidia.so
  fi
}
