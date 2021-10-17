################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="tegra-bsp"
if [ ! $DEVICE == "Switch" ]; then
  PKG_VERSION="32.4.4"
else
  PKG_VERSION="32.3.1"
fi
PKG_ARCH="any"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain" 
PKG_SITE="https://developer.nvidia.com/EMBEDDED/linux-tegra%20/"
case "$DEVICE" in
  tx2|xavier|agx)
    PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.4/r32_Release_v4.4-GMC3/T186/Tegra186_Linux_R32.4.4_aarch64.tbz2"
    ;;
  tx1|nano)
    PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.4/r32_Release_v4.4-GMC3/T210/Tegra210_Linux_R32.4.4_aarch64.tbz2"
    ;;
  Switch)
    PKG_URL="https://developer.nvidia.com/embedded/dlc/r32-3-1_Release_v1.0/t210ref_release_aarch64/Tegra210_Linux_R32.3.1_aarch64.tbz2"
    ;;
esac
PKG_TOOLCHAIN="make"
PKG_AUTORECONF="no"

makeinstall_target() {
  mkdir -p $PKG_BUILD/install
  mkdir -p $INSTALL
  cd $PKG_BUILD/install

  # extract BSP files
  tar xf ../nv_tegra/config.tbz2
  tar xf ../nv_tegra/nvidia_drivers.tbz2
  tar xf ../nv_tegra/nv_tools.tbz2
  tar xf ../nv_tegra/nv_sample_apps/nvgstapps.tbz2

  # move lib/* to usr/lib to avoid /lib symlink conflicts
  mv lib/* usr/lib/
  rm -r lib

  # Same for sbin/
  mv usr/sbin/* usr/bin/

  # Move usr/lib/aarch64-linux-gnu/* usr/lib/tegra/* and usr/lib/tegra-egl/* to usr/lib/ for Lakka to resolve libs correctly
  mv usr/lib/aarch64-linux-gnu/* usr/lib/
  mv usr/lib/tegra-egl/* usr/lib/
  mv usr/lib/tegra/*  usr/lib/
  rm -r usr/lib/{tegra-egl,tegra,aarch64-linux-gnu}

  # Remove unneeded files
  rm -rf usr/lib/ld.so.conf usr/lib/ubiquity \
	etc/{systemd,NetworkManager,fstab,lightdm,nv-oem-config.conf.t210,skel,wpa_supplicant.conf,enctune.conf,nv,nvphsd.conf,nvpmodel,xdg}
  
  # Move udev from etc/ to usr/lib/
  cp -PRv etc/udev usr/lib/
 
  # Create firmware in usr/lib/kernel-overlays/base/lib/firmware/
  #mkdir -p usr/lib/kernel-overlays/base/lib/firmware/
  #cp -PRv usr/lib/firmware usr/lib/kernel-overlays/base/lib/
  rm -rf etc/systemd etc/sysctl.d etc/hostname etc/hosts etc/modprobe.d etc/udev etc/modules-load.d var/nvidia
  #rm -rf usr/lib/firmware
  
  # Refresh symlinks
  cd usr/lib/
  ln -sfn libcuda.so.1.1 libcuda.so
  ln -sfn libdrm.so.2 libdrm_nvdc.so
  ln -sfn libnvbufsurface.so.1.0.0 libnvbufsurface.so
  ln -sfn libnvbufsurftransform.so.1.0.0 libnvbufsurftransform.so
  ln -sfn libnvbuf_utils.so.1.0.0 libnvbuf_utils.so
  ln -sfn libnvdsbufferpool.so.1.0.0 libnvdsbufferpool.so
  ln -sfn libnvid_mapper.so.1.0.0 libnvid_mapper.so
  ln -sfn libnvv4l2.so libv4l2.so.0.0.999999
  ln -sfn libnvv4lconvert.so libv4lconvert.so.0.0.999999
  ln -sfn libvulkan.so.1.2.132 libvulkan.so.1.2
  
  #Fix Vulkan ICD
  sed -i 's:libGLX_nvidia.so.0:/usr/lib/libGLX_nvidia.so.0:g' nvidia_icd.json

  #More symlinking

  cd firmware
  rm -r gm20b
  ln -sfn tegra21x gm20b
  cd ../../../
  cd etc
  ln -sfn asound.conf.tegrasndt210ref asound.conf
  cd vulkan/icd.d
  rm nvidia_icd.json
  ln -sfn /usr/lib/nvidia_icd.json nvidia_icd.json
  cd ../../../../
  
  cp -PRv install/* $INSTALL/ 
  cp -Pv $PKG_DIR/assets/alsa-fix.service $INSTALL/usr/lib/systemd/system/
  mkdir -p $INSTALL/usr/lib/systemd/system/multi-user.target.wants
  ln -s $INSTALL/usr/lib/systemd/system/alsa-fix.service $INSTALL/usr/lib/systemd/system/multi-user.target.wants/alsa-fix.service
  cat $PKG_DIR/assets/50-joysticks.conf >> $INSTALL/etc/X11/xorg.conf
  
}

make_target() {
  :
}
