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
if [ ! "${DEVICE}" = "Switch" ]; then
  PKG_VERSION="32.4.4"
else
  PKG_VERSION="32.3.1"
fi
PKG_ARCH="any"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="mesa libglvnd xorg-server"

if [ ! "${VULKAN}" = "" -o ! "${VULKAN}" = "no" ]; then
  PKG_DEPENDS_TARGET+=" vulkan-loader"
fi

PKG_SITE="https://developer.nvidia.com/EMBEDDED/linux-tegra%20/"
case "${DEVICE}" in
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
PKG_TOOLCHAIN="manual"
PKG_AUTORECONF="no"

build_install() {
  if [ ! -d "${PKG_BUILD}"/install ]; then
    #get and extract multimedia api stuff
    if [ -f nvidia-l4t-jetson-multimedia-api_32.3.1-20191209225816_arm64.deb ]; then
      rm -f nvidia-l4t-jetson-multimedia-api_32.3.1-20191209225816_arm64.deb
    fi

    wget https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.3.1-20191209225816_arm64.deb
    mkdir multimedia_api
    cd multimedia_api
    ar x ../nvidia-l4t-jetson-multimedia-api_32.3.1-20191209225816_arm64.deb
    mkdir data
    cd data
    tar xf ../data.tar.bz2
    cd ..
    rm *.tar* debian-binary
    mv data/* ./
    rmdir data
    cp -Pv "${PKG_DIR}"/assets/NvV4l2ElementPlane.cpp usr/src/jetson_multimedia_api/samples/common/classes/

    mkdir -p "${PKG_BUILD}"/install
    mkdir -p "${INSTALL}"  
    cd "${PKG_BUILD}"/install

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
  	etc/{systemd,NetworkManager,fstab,lightdm,nv-oem-config.conf.t210,skel,wpa_supplicant.conf,enctune.conf,nv,nvphsd.conf,nvpmodel,xdg} \
        usr/bin
    rm -rf etc/systemd etc/sysctl.d etc/hostname etc/hosts etc/modprobe.d etc/modules-load.d var/nvidia

    if [ "${DEVICE}" = "Switch" ]; then
      #We package custom versions of this in switch-alsa-ucm-configs package
      rm -rf usr/share/alsa/init/postinit
    fi
    
    # Move udev from etc/ to usr/lib/
    cp -PRv etc/udev usr/lib/
    rm -rf etc/udev

    # Refresh symlinks
    cd usr/lib/
    ln -sfn libcuda.so.1.1 libcuda.so
    mv libdrm.so.2 libdrm_nvdc.so
    ln -sfn libdrm_nvdc.so libdrm.so.2
    ln -sfn libnvbufsurface.so.1.0.0 libnvbufsurface.so
    ln -sfn libnvbufsurftransform.so.1.0.0 libnvbufsurftransform.so
    ln -sfn libnvbuf_utils.so.1.0.0 libnvbuf_utils.so
    ln -sfn libnvdsbufferpool.so.1.0.0 libnvdsbufferpool.so
    ln -sfn libnvid_mapper.so.1.0.0 libnvid_mapper.so
    ln -sfn libnvv4l2.so libv4l2.so.0.0.999999
    ln -sfn libnvv4lconvert.so libv4lconvert.so.0.0.999999
    ln -sfn libv4l2.so.0.0.999999 libv4l2.so.0
    ln -sfn libv4l2.so.0 libv4l2.so
    ln -sfn libv4lconvert.so.0.0.999999 libv4lconvert.so.0
    ln -sfn libv4lconvert.so.0 libv4lconvert.so
    ln -sfn libnvgbm.so libgbm.so.1
    ln -sfn libnvidia-egl-wayland.so libnvidia-egl-wayland.so.1

    mkdir -p aarch64-linux-gnu/libv4l/plugins/nv
    cd aarch64-linux-gnu/libv4l/plugins/nv
    ln -sfn ../../../../libv4l2_nvvideocodec.so libv4l2_nvvideocodec.so
    ln -sfn ../../../../libv4l2_nvvidconv.so  libv4l2_nvvidconv.so
    cd ../../../../

    rm -r libv4l/

    if [ ! "${VULKAN}" = "" -o ! "${VULKAN}" = "no" ]; then
      #Fix Vulkan ICD
      sed -i 's:libGLX_nvidia.so.0:/usr/lib/libGLX_nvidia.so.0:g' nvidia_icd.json
    fi
    
    #Fix glvnd config
    sed -i 's:libEGL_nvidia.so.0:/usr/lib/libEGL_nvidia.so.0:g' nvidia.json
    rm ../share/glvnd/egl_vendor.d/*
    mv nvidia.json ../share/glvnd/egl_vendor.d/10_nvidia.json

    #Fix EGL configs
    sed -i 's:libnvidia-egl-wayland.so.1:/usr/lib/libnvidia-egl-wayland.so.1:g' ../share/egl/egl_external_platform.d/nvidia_wayland.json

    #More symlinking

    cd firmware
    rm -r gm20b
    ln -sfn tegra21x gm20b
    cd ../../../
    cd etc
    ln -sfn asound.conf.tegrasndt210ref asound.conf
    if [ ! "${VULKAN}" = "" -o ! "${VULKAN}" = "no" ]; then
      cd vulkan/icd.d
      rm nvidia_icd.json
      ln -sfn /usr/lib/nvidia_icd.json nvidia_icd.json
      cd ../../../../
    else
      rm ../usr/lib/nvidia_icd.json
      cd ../
    fi 
fi
}

makeinstall_target() {
  build_install
  cp -PRv install/* "${INSTALL}"/
  cp -PRvn install/usr/lib/* "${TOOLCHAIN}"/aarch64-libreelec-linux-gnueabi/sysroot/usr/lib/
  #install multimedia_api_headers
  cp -PRvn multimedia_api/usr/src/jetson_multimedia_api/include/* ${SYSROOT_PREFIX}/usr/include
  mkdir -p "${SYSROOT_PREFIX}"/usr/src/jetson_multimedia_api/samples/common
  cp -PRn multimedia_api/usr/src/jetson_multimedia_api/samples/common/*  "${SYSROOT_PREFIX}"/usr/src/jetson_multimedia_api/samples/common/
  PWD=$(pwd)
  cd ${TOOLCHAIN}/aarch64-libreelec-linux-gnueabi/sysroot/usr/lib/
  rm libv4lconvert.so.0 libv4lconvert.so libv4l2.so.0 libv4l2.so
  mv libv4l2.so.0.0.999999 libv4l2.so.0
  cp libv4l2.so.0 libv4l2.so
  mv libv4lconvert.so.0.0.999999 libv4lconvert.so.0
  cp libv4lconvert.so.0 libv4lconvert.so
  rm libgbm.so.1
  cp libnvgbm.so libgbm.so.1
  #cp libnvgbm.so libgbm.so
  cp libnvidia-egl-wayland.so libvnidia-egl-wayland.so.1
  rm libdrm.so.2
  cp libdrm_nvdc.so libdrm.so.2
  cd $PWD

  if [ "${DEVICE}" = "Switch" ]; then
    if [ "${DISPLAYSERVER}" = "x11" ]; then
      cp -P "${PKG_DIR}"/assets/xorg.conf "${INSTALL}"/etc/X11/
      cat "${PKG_DIR}"/assets/10-monitor.conf >> "${INSTALL}"/etc/X11/xorg.conf
      cat "${PKG_DIR}"/assets/50-joysticks.conf >> "${INSTALL}"/etc/X11/xorg.conf
      cat "${PKG_DIR}"/assets/20-touchscreen.conf >> "${INSTALL}"/etc/X11/xorg.conf
    fi
  fi
}

make_target() {
  :
}
