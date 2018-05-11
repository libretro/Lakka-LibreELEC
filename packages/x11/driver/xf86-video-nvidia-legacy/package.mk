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

PKG_NAME="xf86-video-nvidia-legacy"
PKG_VERSION="340.106"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.nvidia.com/"
[ "$TARGET_ARCH" = "i386" ] && PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86/$PKG_VERSION/NVIDIA-Linux-x86-$PKG_VERSION.run"
[ "$TARGET_ARCH" = "x86_64" ] && PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/$PKG_VERSION/NVIDIA-Linux-x86_64-$PKG_VERSION-no-compat32.run"
PKG_DEPENDS_TARGET="toolchain util-macros linux xorg-server libvdpau"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="x11/driver"
PKG_SHORTDESC="xf86-video-nvidia-legacy: The Xorg driver for NVIDIA video chips supporting Geforce 6 and Geforce 7 devices too"
PKG_LONGDESC="These binary drivers provide optimized hardware acceleration of OpenGL applications via a direct-rendering X Server. AGP, PCIe, SLI, TV-out and flat panel displays are also supported. This version only supports GeForce 6xxx and higher of the Geforce GPUs plus complimentary Quadros and nforce."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

unpack() {
  [ -d $PKG_BUILD ] && rm -rf $PKG_BUILD

  sh $SOURCES/$PKG_NAME/$PKG_SOURCE_NAME --extract-only --target $PKG_BUILD
}

make_target() {
  unset LDFLAGS

  cd kernel
    make module CC=$CC SYSSRC=$(kernel_path) SYSOUT=$(kernel_path)
    $STRIP --strip-debug nvidia.ko
  cd ..
}

makeinstall_target() {
  mkdir -p $INSTALL/$XORG_PATH_MODULES/drivers
    cp -P nvidia_drv.so $INSTALL/$XORG_PATH_MODULES/drivers/nvidia-legacy_drv.so
    ln -sf /var/lib/nvidia_drv.so $INSTALL/$XORG_PATH_MODULES/drivers/nvidia_drv.so

  mkdir -p $INSTALL/$XORG_PATH_MODULES/extensions
  # rename to not conflicting with Mesa libGL.so
    cp -P libglx.so* $INSTALL/$XORG_PATH_MODULES/extensions/libglx_nvidia-legacy.so

  mkdir -p $INSTALL/etc/X11
    cp $PKG_DIR/config/*.conf $INSTALL/etc/X11

  mkdir -p $INSTALL/usr/lib
    cp -P libnvidia-glcore.so.$PKG_VERSION $INSTALL/usr/lib
    cp -P libnvidia-ml.so.$PKG_VERSION $INSTALL/usr/lib
      ln -sf /var/lib/libnvidia-ml.so.1 $INSTALL/usr/lib/libnvidia-ml.so.1
    cp -P tls/libnvidia-tls.so.$PKG_VERSION $INSTALL/usr/lib
  # rename to not conflicting with Mesa libGL.so
    cp -P libGL.so* $INSTALL/usr/lib/libGL_nvidia-legacy.so.1

  mkdir -p $INSTALL/$(get_full_module_dir)/nvidia
    ln -sf /var/lib/nvidia.ko $INSTALL/$(get_full_module_dir)/nvidia/nvidia.ko

  mkdir -p $INSTALL/usr/lib/nvidia-legacy
    cp kernel/nvidia.ko $INSTALL/usr/lib/nvidia-legacy

  mkdir -p $INSTALL/usr/bin
    ln -s /var/lib/nvidia-smi $INSTALL/usr/bin/nvidia-smi
    cp nvidia-smi $INSTALL/usr/bin/nvidia-legacy-smi
    ln -s /var/lib/nvidia-xconfig $INSTALL/usr/bin/nvidia-xconfig
    cp nvidia-xconfig $INSTALL/usr/bin/nvidia-legacy-xconfig

  mkdir -p $INSTALL/usr/lib/vdpau
    cp libvdpau_nvidia.so* $INSTALL/usr/lib/vdpau/libvdpau_nvidia-legacy.so.1
    ln -sf /var/lib/libvdpau_nvidia.so $INSTALL/usr/lib/vdpau/libvdpau_nvidia.so
    ln -sf /var/lib/libvdpau_nvidia.so.1 $INSTALL/usr/lib/vdpau/libvdpau_nvidia.so.1
}
