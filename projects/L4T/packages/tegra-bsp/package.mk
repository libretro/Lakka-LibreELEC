# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-2021 Gavin_Darkglider
# Copyright (C) 2021 Team LibreELEC (https://libreelec.tv)

PKG_NAME="tegra-bsp"
PKG_VERSION="${GENERIC_L4T_VERSION}"

PKG_DEPENDS_TARGET="mesa libglvnd xorg-server"
PKG_DEPENDS_HOST="xorg-server"

if [  "${VULKAN}" = "" -o "${VULKAN}" = "no" ]; then
  :
else
  PKG_DEPENDS_TARGET+=" vulkan-loader"
fi

PKG_SITE="https://developer.nvidia.com/EMBEDDED/linux-tegra%20/"

case "${L4T_DEVICE_TYPE}" in
  t210)
    case "${GENERIC_L4T_VERSION}" in
      32.3.1)
        PKG_URL="https://developer.nvidia.com/embedded/dlc/r32-3-1_Release_v1.0/t210ref_release_aarch64/Tegra210_Linux_R32.3.1_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.3.1-20191209225816_arm64.deb"
        ;;
      32.4.2)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.2/t210ref_release_aarch64/Tegra210_Linux_R32.4.2_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.2-20200408182156_arm64.deb"
        ;;
      32.4.3)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.3/t210ref_release_aarch64/Tegra210_Linux_R32.4.3_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.3-20200625213809_arm64.deb"
        ;;
      32.4.4)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.4/r32_Release_v4.4-GMC3/T210/Tegra210_Linux_R32.4.4_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.4-20201027211359_arm64.deb"
        ;;
      32.5)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v5.0/T210/Tegra210_Linux_R32.5.0_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.0-20210115145440_arm64.deb"
        ;;
      32.5.1)
        PKG_URL="https://developer.nvidia.com/embedded/l4t/r32_release_v5.2/t210/jetson-210_linux_r32.5.2_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.1-20210519110732_arm64.deb"
        ;;
      32.5.2)
        PKG_URL="https://developer.nvidia.com/embedded/l4t/r32_release_v5.2/t210/jetson-210_linux_r32.5.2_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.2-20210709090126_arm64.deb"
        ;;
      32.6.1)
        PKG_URL="https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t210/jetson-210_linux_r32.6.1_aarch64.tbz2"
        MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t210/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.6.1-20210916211029_arm64.deb"
        ;;
      *)
        echo L4T-r"${GENERIC_L4T_VERSION}" is not supported
        exit 1
        ;;
    esac
    ;;
  t18x | t19x)
    case "${GENERIC_L4T_VERSION}" in
      32.3.1)
        PKG_URL="https://developer.nvidia.com/embedded/dlc/r32-3-1_Release_v1.0/t186ref_release_aarch64/Tegra186_Linux_R32.3.1_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.3.1-20191209230245_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.3.1-20191209230245_arm64.deb"
        fi
        ;;
      32.4.2)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.2/t186ref_release_aarch64/Tegra186_Linux_R32.4.2_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.2-20200408182620_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.2-20200408182620_arm64.deb"
        fi
        ;;
      32.4.3)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.3/t186ref_release_aarch64/Tegra186_Linux_R32.4.3_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.3-20200625213407_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.3-20200625213407_arm64.deb"
        fi
        ;;
      32.4.4)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v4.4/r32_Release_v4.4-GMC3/T186/Tegra186_Linux_R32.4.4_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.4-20201027211332_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.4.4-20201027211332_arm64.deb"
        fi
        ;;
      32.5)
        PKG_URL="https://developer.nvidia.com/embedded/L4T/r32_Release_v5.0/T186/Tegra186_Linux_R32.5.0_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.0-20210115151051_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.0-20210115151051_arm64.deb"
        fi
        ;;
      32.5.1)
        PKG_URL="https://developer.nvidia.com/embedded/l4t/r32_release_v5.2/t186/jetson_linux_r32.5.2_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.1-20210519111140_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.1-20210519111140_arm64.deb"
        fi
        ;;
      32.5.2)
        PKG_URL="https://developer.nvidia.com/embedded/l4t/r32_release_v5.2/t186/jetson_linux_r32.5.2_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.1-20210519111140_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.5.2-20210709090156_arm64.deb"
        fi
        ;;
      32.6.1)
        PKG_URL="https://developer.nvidia.com/embedded/l4t/r32_release_v6.1/t186/jetson_linux_r32.6.1_aarch64.tbz2"
        if [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t186/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.6.1-20210916210945_arm64.deb"
        else
          MEDIA_API_URL="https://repo.download.nvidia.com/jetson/t194/pool/main/n/nvidia-l4t-jetson-multimedia-api/nvidia-l4t-jetson-multimedia-api_32.6.1-20210726122859_arm64.deb"
        fi
        ;;
      *)
        echo L4T-r"${GENERIC_L4T_VERSION}" is not supported
        exit 1
        ;;
    esac
    ;;
  *)
    echo L4T Tegra Platform "${L4T_DEVICE_TYPE}" is not supported
    exit 1
    ;;
esac

PKG_TOOLCHAIN="manual"
PKG_AUTORECONF="no"


make_host() {
  if [ -d "${PKG_BUILD}/host_install" ]; then
    rm -r "${PKG_BUILD}/host_install"
  fi
  mkdir -p "${PKG_BUILD}/host_install"
  #Fetch and extract Multimedia API
  wget ${MEDIA_API_URL}
  MEDIA_API_FILENAME=$(echo "${MEDIA_API_URL}" | sed 's:.*/::') #Hack to get filename of multimedia deb from url.
  mkdir multimedia_api
  cd multimedia_api
  ar x ../${MEDIA_API_FILENAME}
  mkdir data
  cd data
  tar xf ../data.tar.bz2
  cd ..
  rm *.tar* debian-binary
  mv data/* ${PKG_BUILD}/host_install/
  rm -r data
  cd ..
  rm -rf multimedia_api

  cd ${PKG_BUILD}/host_install

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

  #Symlink all files from nvidia locations to locations that libreELEC will link with.
  #And skip symlinks
  cd usr/lib/aarch64-linux-gnu/tegra
    for filename in *; do
      if [ -h "${filename}" ]; then
        :
        #rm -f ${filename}
      else
        ln -sf aarch64-linux-gnu/tegra/${filename} ../../${filename}
      fi
    done
    cd ../tegra-egl
    for filename in *; do
      if [ -h "${filename}" ]; then
        :
        #rm  ${filename}
      else
        ln -sf aarch64-linux-gnu/tegra-egl/${filename} ../../${filename}
      fi
    done
    cd ..
    for filename in *; do
      if [ -h "${filename}" ]; then
        :
        #rm  ${filename}
      else
        ln -sf aarch64-linux-gnu/${filename} ../${filename}
      fi
    done
    cd ../../../

  # Remove unneeded files
  rm -rf usr/lib/ld.so.conf usr/lib/ubiquity etc var opt usr/lib/nvidia usr/share usr/lib/systemd usr/bin usr/sbin usr/lib/firmware usr/lib/xorg
  rm usr/lib/aarch64-linux-gnu/tegra/nvidia_icd.json usr/lib/aarch64-linux-gnu/tegra-egl/nvidia.json

  #remove not needed symlinks
  rm usr/lib/libv4l usr/lib/tegra usr/lib/tegra-egl usr/lib/nvidia.json usr/lib/nvidia_icd.json

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
  ln -sfn libv4l2.so.0.0.999999 libv4l2.so.0
  ln -sfn libv4l2.so.0 libv4l2.so
  ln -sfn libv4lconvert.so.0.0.999999 libv4lconvert.so.0
  ln -sfn libv4lconvert.so.0 libv4lconvert.so
  ln -sfn libnvgbm.so libgbm.so.1
  ln -sfn libnvidia-egl-wayland.so libnvidia-egl-wayland.so.1
}

make_init() {
  if [ -d "${PKG_BUILD}"/init_install ]; then
    rm -rf "${PKG_BUILD}"/init_install
  fi

  mkdir -p "${PKG_BUILD}"/init_install/extract
  mkdir -p "${PKG_BUILD}"/init_install/usr/lib/firmware
  cd "${PKG_BUILD}"/init_install/extract
  # extract BSP files
  tar xf ../../nv_tegra/nvidia_drivers.tbz2
  if [ "${L4T_DEVICE_TYPE}" = "t210" ]; then
    cp lib/firmware/tegra21x_xusb_firmware ../usr/lib/firmware/
  elif [ "${L4T_DEVICE_TYPE}" = "t18x" ]; then
    :
  elif [ "${L4T_DEVICE_TYPE}" = "t19x" ]; then
    :
  fi
  cd ..
  rm -rf extract
}

make_target() {
  if [ -d ${PKG_BUILD}/target_install ]; then
    rm -rf ${PKG_BUILD}/target_install
  fi

  mkdir -p ${PKG_BUILD}/target_install
  cd ${PKG_BUILD}/target_install
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

  #Symlink all files from nvidia locations to locations that libreELEC will link with.
  #And skip symlinks
  cd usr/lib/aarch64-linux-gnu/tegra
    for filename in *; do
      if [ -h "${filename}" ]; then
        :
        #rm -f ${filename}
      else
        ln -sf aarch64-linux-gnu/tegra/${filename} ../../${filename}
      fi
    done
    cd ../tegra-egl
    for filename in *; do
      if [ -h "${filename}" ]; then
        :
        #rm  ${filename}
      else
        ln -sf aarch64-linux-gnu/tegra-egl/${filename} ../../${filename}
      fi
    done
    cd ..
    for filename in *; do
      if [ -h "${filename}" ]; then
        :
        #rm  ${filename}
      else
        ln -sf aarch64-linux-gnu/${filename} ../${filename}
      fi
    done
    cd ../../../

  # Remove unneeded files
  rm -rf usr/lib/ld.so.conf usr/lib/ubiquity \
	etc/{systemd,NetworkManager,fstab,lightdm,nv-oem-config.conf.t210,skel,wpa_supplicant.conf,enctune.conf,nv,nvphsd.conf,nvpmodel,xdg} \
      usr/bin usr/sbin
  rm -rf etc/systemd etc/sysctl.d etc/hostname etc/hosts etc/modprobe.d etc/modules-load.d var/nvidia usr/lib/systemd
  rm -rf usr/lib/nvidia usr/share/backgrounds usr/share/doc usr/share/nvpmodel_indicator usr/share/polkit-1
  rm -rf opt var

  #remove not needed symlinks
  rm usr/lib/libv4l usr/lib/tegra usr/lib/tegra-egl  usr/lib/nvidia.json

  if [ "${DEVICE}" = "Switch" ]; then
    #We dont need these with Switch UCM
    rm -rf usr/share/alsa/init
  fi

  # Move udev from etc/ to usr/lib/
  cp -PRv etc/udev usr/lib/
  rm -rf etc/udev

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
  ln -sfn libv4l2.so.0.0.999999 libv4l2.so.0
  ln -sfn libv4l2.so.0 libv4l2.so
  ln -sfn libv4lconvert.so.0.0.999999 libv4lconvert.so.0
  ln -sfn libv4lconvert.so.0 libv4lconvert.so
  ln -sfn libnvgbm.so libgbm.so.1
  ln -sfn libnvidia-egl-wayland.so libnvidia-egl-wayland.so.1

  if [ ! "${VULKAN}" = "" -a ! "${VULKAN}" = "no" ]; then
    #Fix Vulkan ICD
    sed -i 's:libGLX_nvidia.so.0:/usr/lib/libGLX_nvidia.so.0:g' aarch64-linux-gnu/tegra/nvidia_icd.json
  fi

  #Fix glvnd config
  sed -i 's:libEGL_nvidia.so.0:/usr/lib/libEGL_nvidia.so.0:g' aarch64-linux-gnu/tegra-egl/nvidia.json
  rm ../share/glvnd/egl_vendor.d/*
  mv aarch64-linux-gnu/tegra-egl/nvidia.json ../share/glvnd/egl_vendor.d/10_nvidia.json

  #Fix EGL configs
  sed -i 's:libnvidia-egl-wayland.so.1:/usr/lib/libnvidia-egl-wayland.so.1:g' ../share/egl/egl_external_platform.d/nvidia_wayland.json

  #More symlinking

  cd firmware
  rm -r gm20b
  ln -sfn tegra21x gm20b
  cd ../../../
  cd etc
  ln -sfn asound.conf.tegrasndt210ref asound.conf
  if [ ! "${VULKAN}" = "" -a ! "${VULKAN}" = "no" ]; then
    cd vulkan/icd.d
    rm nvidia_icd.json
    ln -sfn /usr/lib/nvidia_icd.json nvidia_icd.json
    cd ../../../../
  else
    rm ../usr/lib/nvidia_icd.json
    cd ../
  fi
}

makeinstall_host() {
  PWD=$(pwd)
  cd ${PKG_BUILD}/host_install/usr/
  cd src
  for filename in *; do
    rm -rf  ${SYSROOT_PREFIX}/usr/src/${filename}
  done
  cd ${PWD}
  #Install host
  cp -PRv ${PKG_BUILD}/host_install/* ${SYSROOT_PREFIX}/
}

makeinstall_init() {
  if [ -d "${INSTALL}" ]; then
    rm -rf ${INSTALL}
  fi
  mkdir -p ${INSTALL}/{firmware,splash}
  cp -PRv ${PKG_BUILD}/init_install/* ${INSTALL}/

  if [ -d "${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/initramfs/firmware" ]; then
    PWD="$(pwd)"
    cd ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/initramfs/firmware/
    cp -r * ${INSTALL}/usr/lib/firmware
    cd ${PWD}
  fi

  if [ -d ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/initramfs/splash ]; then
    if [ "${DISTRO}" = "Lakka" ]; then
      cp ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/initramfs/splash/splash-1280-lakka.png ${INSTALL}/splash/splash-1280.png
    elif [ "${DISTRO}" = "LibreELEC" ]; then
      cp ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/initramfs/splash/splash-1280-libreelec.png ${INSTALL}/splash/splash-1280.png
    fi
  fi

}

makeinstall_target() {
  if [ ! -d "${INSTALL}" ]; then
    mkdir -p ${INSTALL}
  fi
  #Install target
  cp -PRv ${PKG_BUILD}/target_install/* ${INSTALL}/

  if [ "${DEVICE}" = "Switch" ]; then
    if [ "${DISPLAYSERVER}" = "x11" ]; then
      cp -P ${PKG_DIR}/assets/xorg.conf ${INSTALL}/etc/X11/
      cat ${PKG_DIR}/assets/10-monitor.conf >> ${INSTALL}/etc/X11/xorg.conf
      cat ${PKG_DIR}/assets/50-joysticks.conf >> ${INSTALL}/etc/X11/xorg.conf
      cat ${PKG_DIR}/assets/20-touchscreen.conf >> ${INSTALL}/etc/X11/xorg.conf
    fi
  fi
}

