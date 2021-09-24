# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xf86-video-nvidia"
# Remember to run "python packages/x11/driver/xf86-video-nvidia/scripts/make_nvidia_udev.py" and commit changes to
# "packages/x11/driver/xf86-video-nvidia/udev.d/96-nvidia.rules" whenever bumping version.
# Host may require installation of python3-lxml and python3-requests packages.
PKG_VERSION="460.67"
PKG_SHA256="a19253cf805f913a3b53098587d557fb21c9b57b1568cb630e128ebb3276c10e"
PKG_ARCH="x86_64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.nvidia.com/"
PKG_URL="http://us.download.nvidia.com/XFree86/Linux-x86_64/$PKG_VERSION/NVIDIA-Linux-x86_64-$PKG_VERSION-no-compat32.run"
PKG_DEPENDS_TARGET="toolchain util-macros linux xorg-server libvdpau"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="The Xorg driver for NVIDIA video chips."
PKG_TOOLCHAIN="manual"

unpack() {
  [ -d $PKG_BUILD ] && rm -rf $PKG_BUILD

  sh $SOURCES/$PKG_NAME/$PKG_SOURCE_NAME --extract-only --target $PKG_BUILD
}

make_target() {
  unset LDFLAGS

  cd kernel
    make module CC=${CC} LD=${LD} SYSSRC=$(kernel_path) SYSOUT=$(kernel_path)
    $STRIP --strip-debug nvidia.ko
  cd ..
}

makeinstall_target() {
  mkdir -p $INSTALL/$XORG_PATH_MODULES/drivers
    cp -P nvidia_drv.so $INSTALL/$XORG_PATH_MODULES/drivers/nvidia-main_drv.so
    ln -sf /var/lib/nvidia_drv.so $INSTALL/$XORG_PATH_MODULES/drivers/nvidia_drv.so

  mkdir -p $INSTALL/$XORG_PATH_MODULES/extensions
  # rename to not conflicting with Mesa libGL.so
    cp -P libglxserver_nvidia.so.$PKG_VERSION $INSTALL/$XORG_PATH_MODULES/extensions/libglx_nvidia.so

  mkdir -p $INSTALL/etc/X11
    cp $PKG_DIR/config/*.conf $INSTALL/etc/X11

  mkdir -p $INSTALL/usr/lib
    cp -P libnvidia-glcore.so.$PKG_VERSION $INSTALL/usr/lib
    cp -P libnvidia-ml.so.$PKG_VERSION $INSTALL/usr/lib
      ln -sf /var/lib/libnvidia-ml.so.1 $INSTALL/usr/lib/libnvidia-ml.so.1
    cp -P libnvidia-tls.so.$PKG_VERSION $INSTALL/usr/lib
  # rename to not conflicting with Mesa libGL.so
    cp -P libGL.so.$PKG_VERSION $INSTALL/usr/lib/libGL_nvidia.so.1

  mkdir -p $INSTALL/$(get_full_module_dir)/nvidia
    ln -sf /var/lib/nvidia.ko $INSTALL/$(get_full_module_dir)/nvidia/nvidia.ko
    cp -P kernel/nvidia-uvm.ko $INSTALL/$(get_full_module_dir)/nvidia
    cp -P kernel/nvidia-modeset.ko $INSTALL/$(get_full_module_dir)/nvidia

  mkdir -p $INSTALL/usr/lib/nvidia
    cp -P kernel/nvidia.ko $INSTALL/usr/lib/nvidia

  mkdir -p $INSTALL/usr/bin
    ln -s /var/lib/nvidia-smi $INSTALL/usr/bin/nvidia-smi
    cp nvidia-smi $INSTALL/usr/bin/nvidia-main-smi
    ln -s /var/lib/nvidia-xconfig $INSTALL/usr/bin/nvidia-xconfig
    cp nvidia-xconfig $INSTALL/usr/bin/nvidia-main-xconfig

  mkdir -p $INSTALL/usr/lib/vdpau
    cp libvdpau_nvidia.so* $INSTALL/usr/lib/vdpau/libvdpau_nvidia-main.so.1
    ln -sf /var/lib/libvdpau_nvidia.so $INSTALL/usr/lib/vdpau/libvdpau_nvidia.so
    ln -sf /var/lib/libvdpau_nvidia.so.1 $INSTALL/usr/lib/vdpau/libvdpau_nvidia.so.1

# Install Vulkan ICD & SPIR-V lib
  if [ "${VULKAN_SUPPORT}" = "yes" ]; then
    cp -P libnvidia-glvkspirv.so.${PKG_VERSION} ${INSTALL}/usr/lib 
    mkdir -p ${INSTALL}/usr/share/vulkan/icd.d
    if [ -f nvidia_icd.json.template ]; then
      sed "s#__NV_VK_ICD__#/usr/lib/libGLX_nvidia.so.0#" nvidia_icd.json.template > ${INSTALL}/usr/share/vulkan/icd.d/nvidia_icd.json
    elif [ -f nvidia_icd.json ]; then
      cp -P nvidia_icd.json ${INSTALL}/usr/share/vulkan/icd.d/
    fi
  fi
}
