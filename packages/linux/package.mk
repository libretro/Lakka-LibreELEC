# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="linux"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kernel.org"
PKG_DEPENDS_HOST="ccache:host rsync:host"
PKG_DEPENDS_TARGET="linux:host kmod:host xz:host keyutils openssl:host ${KERNEL_EXTRA_DEPENDS_TARGET}"
PKG_NEED_UNPACK="${LINUX_DEPENDS} $(get_pkg_directory initramfs) $(get_pkg_variable initramfs PKG_NEED_UNPACK)"
PKG_LONGDESC="This package contains a precompiled kernel image and the modules."
PKG_IS_KERNEL_PKG="yes"
PKG_STAMP="${KERNEL_TARGET} ${KERNEL_MAKE_EXTRACMD}"

PKG_PATCH_DIRS="${LINUX}"

case "${LINUX}" in
  amlogic)
    PKG_VERSION="16f603617dbbc30cafbacaf78ef6468a081fa482" # 6.1.38
    PKG_SHA256="aab5563a0ff2f7581b8f40d28950d4e9a30e51ea72397e3bf26efd85719af28c"
    PKG_URL="https://github.com/torvalds/linux/archive/${PKG_VERSION}.tar.gz"
    PKG_SOURCE_NAME="linux-${LINUX}-${PKG_VERSION}.tar.gz"
    PKG_PATCH_DIRS="default"
    ;;
  raspberrypi)
    PKG_VERSION="14c373b069031f01031e113f62d65c7518f0f084" # 6.1.77
    PKG_SHA256="1af26cc6cc5dfdf1df874f7f86bbaf0fc48fc7a1af03a3da15c9202da5f6d3cd"
    PKG_URL="https://github.com/raspberrypi/linux/archive/${PKG_VERSION}.tar.gz"
    PKG_SOURCE_NAME="linux-${LINUX}-${PKG_VERSION}.tar.gz"
    ;;
  L4T)
    PKG_VERSION=${DEVICE}-${SWITCHROOT_VERSION}
    PKG_URL="l4t-kernel-sources"
    GET_HANDLER_SUPPORT="l4t-kernel-sources"
    PKG_PATCH_DIRS="${PROJECT} ${PROJECT}/${DEVICE}"
    PKG_SOURCE_NAME="linux-$DEVICE.tar.gz"
    #Need to find a better way to do this for l4t platforms!
    PKG_SHA256=$L4T_COMBINED_KERNEL_SHA256
    ;;
  ayn-odin)
   PKG_SHA256="9aa25bf492928bc7a4542e87d28919c9ac36d27c"
   PKG_VERSION="${PKG_SHA256}"
   PKG_URL="https://gitlab.com/sdm845-mainline/linux.git"
   PKG_PATCH_DIRS="ayn-odin"
   PKG_GIT_CLONE_BRANCH="sdm845-5.19.16"
   ;;
  *)
    PKG_VERSION="6.1.80"
    PKG_SHA256="568ecaaebb8b87c7c8246bba67bc83402972bf34f5811651a2d3cd548ff7b671"
    PKG_URL="https://www.kernel.org/pub/linux/kernel/v${PKG_VERSION/.*/}.x/${PKG_NAME}-${PKG_VERSION}.tar.xz"
    PKG_PATCH_DIRS="default"
    ;;
esac

PKG_KERNEL_CFG_FILE=$(kernel_config_path) || die

PKG_PATCH_DIRS+=" ${DISTRO}-${LINUX}"

if [ -n "${KERNEL_TOOLCHAIN}" ]; then
  PKG_DEPENDS_TARGET+=" gcc-${KERNEL_TOOLCHAIN}:host"
  HEADERS_ARCH=${TARGET_ARCH}
else
  PKG_DEPENDS_TARGET+=" toolchain"
fi

if [ "${PKG_BUILD_PERF}" != "no" ] && grep -q ^CONFIG_PERF_EVENTS= ${PKG_KERNEL_CFG_FILE}; then
  PKG_BUILD_PERF="yes"
  PKG_DEPENDS_TARGET+=" binutils elfutils libunwind zlib openssl"
fi

if [ "${TARGET_ARCH}" = "x86_64" -o "${TARGET_ARCH}" = "i386" ]; then
  PKG_DEPENDS_TARGET+=" elfutils:host pciutils"
  PKG_DEPENDS_UNPACK+=" intel-ucode kernel-firmware"
elif [ "${TARGET_ARCH}" = "arm" -a "${DEVICE}" = "iMX6" ]; then
  PKG_DEPENDS_UNPACK+=" firmware-imx"
fi

if [[ "${KERNEL_TARGET}" = uImage* ]]; then
  PKG_DEPENDS_TARGET+=" u-boot-tools:host"
fi

# Ensure that the dependencies of initramfs:target are built correctly, but
# we don't want to add initramfs:target as a direct dependency as we install
# this "manually" from within linux:target
for pkg in $(get_pkg_variable initramfs PKG_DEPENDS_TARGET); do
  ! listcontains "${PKG_DEPENDS_TARGET}" "${pkg}" && PKG_DEPENDS_TARGET+=" ${pkg}" || true
done

post_patch() {
  # linux was already built and its build dir autoremoved - prepare it again for kernel packages
  if [ -d ${PKG_INSTALL}/.image ]; then
    cp -p ${PKG_INSTALL}/.image/.config ${PKG_BUILD}
    kernel_make -C ${PKG_BUILD} prepare

    # restore the required Module.symvers from an earlier build
    cp -p ${PKG_INSTALL}/.image/Module.symvers ${PKG_BUILD}
  fi
}

make_host() {
 :
}

makeinstall_host() {
  make \
    ARCH=${HEADERS_ARCH:-$TARGET_KERNEL_ARCH} \
    HOSTCC="${TOOLCHAIN}/bin/host-gcc" \
    HOSTCXX="${TOOLCHAIN}/bin/host-g++" \
    HOSTCFLAGS="${HOST_CFLAGS}" \
    HOSTCXXFLAGS="${HOST_CXXFLAGS}" \
    HOSTLDFLAGS="${HOST_LDFLAGS}" \
    INSTALL_HDR_PATH=dest \
    headers_install

  mkdir -p ${SYSROOT_PREFIX}/usr/include
    cp -R dest/include/* ${SYSROOT_PREFIX}/usr/include
}

pre_make_target() {
  ( cd ${ROOT}
    rm -rf ${BUILD}/initramfs
    rm -f ${STAMPS_INSTALL}/initramfs/install_target ${STAMPS_INSTALL}/*/install_init
    ${SCRIPTS}/install initramfs
  )
  pkg_lock_status "ACTIVE" "linux:target" "build"

  cp ${PKG_KERNEL_CFG_FILE} ${PKG_BUILD}/.config
  # set initramfs source
  ${PKG_BUILD}/scripts/config --set-str CONFIG_INITRAMFS_SOURCE "$(kernel_initramfs_confs) ${BUILD}/initramfs"

  # set default hostname based on ${DISTRONAME}
  ${PKG_BUILD}/scripts/config --set-str CONFIG_DEFAULT_HOSTNAME "${DISTRONAME}"

  # disable swap support if not enabled
  if [ ! "${SWAP_SUPPORT}" = yes ]; then
    ${PKG_BUILD}/scripts/config --disable CONFIG_SWAP
  fi

  # disable nfs support if not enabled
  if [ ! "${NFS_SUPPORT}" = yes ]; then
    ${PKG_BUILD}/scripts/config --disable CONFIG_NFS_FS
  fi

  # disable cifs support if not enabled
  if [ ! "${SAMBA_SUPPORT}" = yes ]; then
    ${PKG_BUILD}/scripts/config --disable CONFIG_CIFS
  fi

  # disable iscsi support if not enabled
  if [ ! "${ISCSI_SUPPORT}" = yes ]; then
    ${PKG_BUILD}/scripts/config --disable CONFIG_SCSI_ISCSI_ATTRS
    ${PKG_BUILD}/scripts/config --disable CONFIG_ISCSI_TCP
    ${PKG_BUILD}/scripts/config --disable CONFIG_ISCSI_BOOT_SYSFS
    ${PKG_BUILD}/scripts/config --disable CONFIG_ISCSI_IBFT_FIND
    ${PKG_BUILD}/scripts/config --disable CONFIG_ISCSI_IBFT
  fi

  # disable lima/panfrost if libmali is configured
  if [ "${OPENGLES}" = "libmali" ]; then
    ${PKG_BUILD}/scripts/config --disable CONFIG_DRM_LIMA
    ${PKG_BUILD}/scripts/config --disable CONFIG_DRM_PANFROST
  fi

  # disable wireguard support if not enabled
  if [ ! "${WIREGUARD_SUPPORT}" = yes ]; then
    ${PKG_BUILD}/scripts/config --disable CONFIG_WIREGUARD
  fi

  # enable nouveau driver when required
  if [ ! "${LINUX}" = "L4T" ]; then
    if listcontains "${GRAPHIC_DRIVERS}" "nouveau"; then
      ${PKG_BUILD}/scripts/config --module CONFIG_DRM_NOUVEAU
      ${PKG_BUILD}/scripts/config --enable CONFIG_DRM_NOUVEAU_BACKLIGHT
      ${PKG_BUILD}/scripts/config --set-val CONFIG_NOUVEAU_DEBUG 5
      ${PKG_BUILD}/scripts/config --set-val CONFIG_NOUVEAU_DEBUG_DEFAULT 3
    fi
  fi

  # enable MIDI for Lakka on x86_64, i386 has options set in linux config file
  if [ "${DISTRO}" = "Lakka" -a "${TARGET_ARCH}" = "x86_64" ]; then
    ${PKG_BUILD}/scripts/config \
                                --module CONFIG_SND_SEQ_DEVICE \
                                --module CONFIG_SND_SEQUENCER \
                                --enable CONFIG_SND_SEQ_HRTIMER_DEFAULT \
                                --module CONFIG_SND_SEQ_MIDI_EVENT \
                                --module CONFIG_SND_SEQ_MIDI \
                                --module CONFIG_SND_SEQ_MIDI_EMUL \
                                --module CONFIG_SND_SEQ_VIRMIDI \
                                --module CONFIG_SND_OPL3_LIB_SEQ \
                                --module CONFIG_SND_EMU10K1_SEQ \
                                --module CONFIG_SND_SYNTH_EMUX
  fi

  # enable Gamecon for Lakka on x86_64, i386 has options set in linux config file
  if [ "${DISTRO}" = "Lakka" -a "${TARGET_ARCH}" = "x86_64" ]; then
    ${PKG_BUILD}/scripts/config \
                                --module CONFIG_JOYSTICK_GAMECON \
                                --module CONFIG_PARPORT \
                                --module CONFIG_PARPORT_PC \
                                --module CONFIG_PARPORT_SERIAL \
                                --enable CONFIG_PARPORT_PC_FIFO \
                                --enable CONFIG_PARPORT_PC_SUPERIO \
                                --module CONFIG_PARPORT_AX88796 \
                                --enable CONFIG_PARPORT_1284 \
                                --enable CONFIG_PARPORT_NOT_PC
  fi

  # enable Ventoy support
  if [ "${DISTRO}" = "Lakka" -a "${PROJECT}" = "Generic" ]; then
    ${PKG_BUILD}/scripts/config \
                                --enable CONFIG_BLK_DEV_DM
  fi

  # enable Dualsense on default and raspberrypi kernels for Lakka
  if [ "${DISTRO}" = "Lakka" ] && [ "${LINUX}" = "default" -o "${LINUX}" = "raspberrypi" ]; then
    ${PKG_BUILD}/scripts/config \
                                --enable CONFIG_HID_PLAYSTATION \
                                --enable CONFIG_PLAYSTATION_FF \
                                --enable CONFIG_LEDS_CLASS_MULTICOLOR \
                                --enable CONFIG_LEDS_CLASS
  fi

  # enable additional USB / WIFI for CM4 / RetroDreamer / PiBoyDMG
  if [ "${DISTRO}" = "Lakka" ] && [ "${DEVICE:0:4}" = "RPi4" ]; then
    ${PKG_BUILD}/scripts/config --module CONFIG_USB_DWC2
    ${PKG_BUILD}/scripts/config --module CONFIG_R8188EU
  fi

  # enable joystick and eMMC support for Exynos / OdroidXU4
  if [ "${DISTRO}" = "Lakka" ] && [ "${DEVICE}" = "Exynos" ]; then
    ${PKG_BUILD}/scripts/config --enable CONFIG_INPUT_JOYSTICK \
                                --module CONFIG_JOYSTICK_GF2K \
                                --module CONFIG_JOYSTICK_IFORCE \
                                --module CONFIG_JOYSTICK_IFORCE_USB \
                                --module CONFIG_JOYSTICK_XPAD \
                                --enable CONFIG_JOYSTICK_XPAD_FF \
                                --enable CONFIG_JOYSTICK_XPAD_LEDS \
                                --enable CONFIG_INPUT_MISC \
                                --module CONFIG_PWRSEQ_SD8787 \
                                --module CONFIG_SDIO_UART \
                                --module CONFIG_ARM_AMBA \
                                --module CONFIG_ARMMMCI \
                                --module CONFIG_MMC_ARMMMCI \
                                --module MMC_SDHCI_PLTFM \
                                --enable CONFIG_MMC_STM32_SDMMC \
                                --enable CONFIG_MMC_SDHCI_IO_ACCESSORS \
                                --module CONFIG_MMC_SDHCI_OF_ARASAN \
                                --module CONFIG_MMC_SDHCI_OF_ASPEED \
                                --module CONFIG_MMC_SDHCI_OF_AT91 \
                                --module CONFIG_MMC_SDHCI_OF_DWCMSHC \
                                --module CONFIG_MMC_SDHCI_CADENCE \
                                --module CONFIG_MMC_SPI \
                                --module CONFIG_MMC_VUB300 \
                                --module CONFIG_MMC_USHC \
                                --module CONFIG_MMC_USDHI6ROL0 \
                                --module CONFIG_MMC_REALTEK_USB \
                                --module CONFIG_MMC_CQHCI \
                                --module CONFIG_MMC_MTK \
                                --module CONFIG_MMC_SDHCI_XENON \
                                --module CONFIG_MMC_SDHCI_OMAP \
                                --module CONFIG_MMC_SDHCI_AM654 \
                                --module CONFIG_MEMSTICK \
                                --module CONFIG_MSPRO_BLOCK \
                                --module CONFIG_MS_BLOCK \
                                --module CONFIG_MEMSTICK_REALTEK_USB
  fi

  # install extra dts files for Lakka
  if [ "${DISTRO}" = "Lakka" ]; then
    for f in ${PROJECT_DIR}/${PROJECT}/config/*-overlay.dts ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/config/*-overlay.dts ; do
      [ -f "${f}" ] && cp -v ${f} ${PKG_BUILD}/arch/${TARGET_KERNEL_ARCH}/boot/dts/overlays || true
    done
  fi

  if [ "${TARGET_ARCH}" = "x86_64" -o "${TARGET_ARCH}" = "i386" ]; then
    # copy some extra firmware to linux tree
    mkdir -p ${PKG_BUILD}/external-firmware
      cp -a $(get_build_dir kernel-firmware)/.copied-firmware/{amdgpu,amd-ucode,i915,radeon,e100,rtl_nic} ${PKG_BUILD}/external-firmware

    cp -a $(get_build_dir intel-ucode)/intel-ucode ${PKG_BUILD}/external-firmware

    FW_LIST="$(find ${PKG_BUILD}/external-firmware \( -type f -o -type l \) \( -iname '*.bin' -o -iname '*.fw' -o -path '*/intel-ucode/*' \) | sed 's|.*external-firmware/||' | sort | xargs)"

    ${PKG_BUILD}/scripts/config --set-str CONFIG_EXTRA_FIRMWARE "${FW_LIST}"
    ${PKG_BUILD}/scripts/config --set-str CONFIG_EXTRA_FIRMWARE_DIR "external-firmware"

  elif [ "${TARGET_ARCH}" = "arm" -a "${DEVICE}" = "iMX6" ]; then
    mkdir -p ${PKG_BUILD}/external-firmware/imx/sdma
      cp -a $(get_build_dir firmware-imx)/firmware/sdma/*imx6*.bin ${PKG_BUILD}/external-firmware/imx/sdma
      cp -a $(get_build_dir firmware-imx)/firmware/vpu/*imx6*.bin ${PKG_BUILD}/external-firmware

    FW_LIST="$(find ${PKG_BUILD}/external-firmware -type f | sed 's|.*external-firmware/||' | sort | xargs)"

    ${PKG_BUILD}/scripts/config --set-str CONFIG_EXTRA_FIRMWARE "${FW_LIST}"
    ${PKG_BUILD}/scripts/config --set-str CONFIG_EXTRA_FIRMWARE_DIR "external-firmware"
  fi

  # enable rumble for PID-compliant game controllers
  if [ "${DISTRO}" = "Lakka" ] && [ ! "${LINUX}" = "L4T" ]; then
    ${PKG_BUILD}/scripts/config --enable CONFIG_HID_PID
  fi

  if [ ! "${LINUX}" = "L4T" ]; then
    if [ -f "${DISTRO_DIR}/${DISTRO}/kernel_options_overrides" ]; then
      while read OPTION; do
        [ -z "${OPTION}" -o -n "$(echo "${OPTION}" | grep '^#')" ] && continue

        OPTION_NAME=${OPTION%%=*}
        OPTION_VAL_OVR=${OPTION##*=}
        OPTION_VAL_CFG=$(${PKG_BUILD}/scripts/config --state ${OPTION_NAME})

        if [ "${OPTION_VAL_OVR}" = "${OPTION_VAL_CFG}" ] || [ "${OPTION_VAL_OVR}" = "n" -a "${OPTION_VAL_CFG}" = "undef" ]; then
          continue
        fi

        case ${OPTION_VAL_OVR} in
          y)
            OPTION_ACTION="enable"
            ;;
          m)
            OPTION_ACTION="module"
            ;;
          n)
            OPTION_ACTION="disable"
            ;;
          *)
            OPTION_ACTION="undefine"
            OPTION_VAL_OVR="u"
            ;;
        esac

        echo -e "Kernel config override: [${OPTION_VAL_OVR}] ${OPTION_NAME}"
        ${PKG_BUILD}/scripts/config --${OPTION_ACTION} ${OPTION_NAME}

      done < ${DISTRO_DIR}/${DISTRO}/kernel_options_overrides

    fi
  fi

  if [ "${LINUX}" = "L4T" ]; then
    kernel_make olddefconfig
    kernel_make prepare
    kernel_make modules_prepare
  elif [ "${DISTRO}" = "Lakka" ]; then
  kernel_make listnewconfig
  yes "" | kernel_make oldconfig > /dev/null
  fi

  if [ -f "${DISTRO_DIR}/${DISTRO}/kernel_options" ]; then
    while read OPTION; do
      [ -z "${OPTION}" -o -n "$(echo "${OPTION}" | grep '^#')" ] && continue

      if [ "${OPTION##*=}" == "n" -a "$(${PKG_BUILD}/scripts/config --state ${OPTION%%=*})" == "undef" ]; then
        continue
      fi

      if [ "$(${PKG_BUILD}/scripts/config --state ${OPTION%%=*})" != "$(echo ${OPTION##*=} | tr -d '"')" ]; then
        MISSING_KERNEL_OPTIONS+="\t${OPTION}\n"
      fi
    done < ${DISTRO_DIR}/${DISTRO}/kernel_options

    if [ -n "${MISSING_KERNEL_OPTIONS}" ]; then
      print_color CLR_WARNING "LINUX: kernel options not correct: \n${MISSING_KERNEL_OPTIONS%%}\nPlease run ./tools/check_kernel_config\n"
    fi
  fi
}

make_target() {
  # arm64 target does not support creating uImage.
  # Build Image first, then wrap it using u-boot's mkimage.
  if [[ "${TARGET_KERNEL_ARCH}" = "arm64" && "${KERNEL_TARGET}" = uImage* ]]; then
    if [ -z "${KERNEL_UIMAGE_LOADADDR}" -o -z "${KERNEL_UIMAGE_ENTRYADDR}" ]; then
      die "ERROR: KERNEL_UIMAGE_LOADADDR and KERNEL_UIMAGE_ENTRYADDR have to be set to build uImage - aborting"
    fi
    KERNEL_UIMAGE_TARGET="${KERNEL_TARGET}"
    KERNEL_TARGET="${KERNEL_TARGET/uImage/Image}"
  fi

  if [ "${LINUX}" = "L4T" ]; then
     export KCFLAGS+=" -Wno-stringop-truncation -Wno-error=stringop-overflow -Wno-maybe-uninitialized -Wno-address-of-packed-member -Wno-packed-not-aligned -Wno-array-bounds"
  fi

  DTC_FLAGS=-@ kernel_make TOOLCHAIN="${TOOLCHAIN}" ${KERNEL_TARGET} ${KERNEL_MAKE_EXTRACMD} modules

  if [ ! "${LINUX}" = "L4T" ]; then
    if [ "${PKG_BUILD_PERF}" = "yes" ]; then
      ( cd tools/perf

        # arch specific perf build args
        case "${TARGET_ARCH}" in
          x86_64)
            PERF_BUILD_ARGS="ARCH=x86"
            ;;
          aarch64)
            PERF_BUILD_ARGS="ARCH=arm64"
            ;;
          *)
            PERF_BUILD_ARGS="ARCH=${TARGET_ARCH}"
            ;;
        esac

        WERROR=0 \
        NO_LIBPERL=1 \
        NO_LIBPYTHON=1 \
        NO_SLANG=1 \
        NO_GTK2=1 \
        NO_LIBNUMA=1 \
        NO_LIBAUDIT=1 \
        NO_LZMA=1 \
        NO_SDT=1 \
        CROSS_COMPILE="${TARGET_PREFIX}" \
        JOBS="${CONCURRENCY_MAKE_LEVEL}" \
          make ${PERF_BUILD_ARGS}
        mkdir -p ${INSTALL}/usr/bin
          cp perf ${INSTALL}/usr/bin
      )
    fi
  fi
  
  if [ -n "${KERNEL_UIMAGE_TARGET}" ]; then
    # determine compression used for kernel image
    KERNEL_UIMAGE_COMP=${KERNEL_UIMAGE_TARGET:7}
    KERNEL_UIMAGE_COMP=$(echo ${KERNEL_UIMAGE_COMP:-none} | sed 's/gz/gzip/; s/bz2/bzip2/')

    # calculate new load address to make kernel Image unpack to memory area after compressed image
    if [ "${KERNEL_UIMAGE_COMP}" != "none" ]; then
      COMPRESSED_SIZE=$(stat -t "arch/${TARGET_KERNEL_ARCH}/boot/${KERNEL_TARGET}" | awk '{print $2}')
      # align to 1 MiB
      COMPRESSED_SIZE=$(( ((${COMPRESSED_SIZE} - 1 >> 20) + 1) << 20 ))
      PKG_KERNEL_UIMAGE_LOADADDR=$(printf '%X' "$(( ${KERNEL_UIMAGE_LOADADDR} + ${COMPRESSED_SIZE} ))")
      PKG_KERNEL_UIMAGE_ENTRYADDR=$(printf '%X' "$(( ${KERNEL_UIMAGE_ENTRYADDR} + ${COMPRESSED_SIZE} ))")
    else
      PKG_KERNEL_UIMAGE_LOADADDR=${KERNEL_UIMAGE_LOADADDR}
      PKG_KERNEL_UIMAGE_ENTRYADDR=${KERNEL_UIMAGE_ENTRYADDR}
    fi

    mkimage -A ${TARGET_KERNEL_ARCH} \
            -O linux \
            -T kernel \
            -C ${KERNEL_UIMAGE_COMP} \
            -a ${PKG_KERNEL_UIMAGE_LOADADDR} \
            -e ${PKG_KERNEL_UIMAGE_ENTRYADDR} \
            -d arch/${TARGET_KERNEL_ARCH}/boot/${KERNEL_TARGET} \
               arch/${TARGET_KERNEL_ARCH}/boot/${KERNEL_UIMAGE_TARGET}

    KERNEL_TARGET="${KERNEL_UIMAGE_TARGET}"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/.image
  cp -p arch/${TARGET_KERNEL_ARCH}/boot/${KERNEL_TARGET} System.map .config Module.symvers ${INSTALL}/.image/

  kernel_make INSTALL_MOD_PATH=${INSTALL}/$(get_kernel_overlay_dir) modules_install
  rm -f ${INSTALL}/$(get_kernel_overlay_dir)/lib/modules/*/build
  rm -f ${INSTALL}/$(get_kernel_overlay_dir)/lib/modules/*/source

  if [ "${BOOTLOADER}" = "switch-bootloader" -o "${BOOTLOADER}" = "odin-bootloader" ]; then
    mkdir -p $INSTALL/usr/share/bootloader/boot/
    if [ "${BOOTLOADER}" = "switch-bootloader" ]; then
      cp arch/arm64/boot/dts/*.dtb ${INSTALL}/usr/share/bootloader/boot/
    else
      cp arch/arm64/boot/dts/qcom/sdm845-ayn-odin.dtb ${INSTALL}/usr/share/bootloader/boot/
    fi
  elif [ "${BOOTLOADER}" = "u-boot" ]; then
    mkdir -p ${INSTALL}/usr/share/bootloader
    for dtb in arch/${TARGET_KERNEL_ARCH}/boot/dts/*.dtb arch/${TARGET_KERNEL_ARCH}/boot/dts/*/*.dtb; do
      if [ -f ${dtb} ]; then
        cp -v ${dtb} ${INSTALL}/usr/share/bootloader
      fi
    done
  elif [ "${BOOTLOADER}" = "bcm2835-bootloader" ]; then
    # RPi firmware will decompress gzipped kernels prior to booting
    if [ "${TARGET_KERNEL_ARCH}" = "arm64" ]; then
      pigz --best --force ${INSTALL}/.image/${KERNEL_TARGET}
      mv ${INSTALL}/.image/${KERNEL_TARGET}.gz ${INSTALL}/.image/${KERNEL_TARGET}
    fi

    mkdir -p ${INSTALL}/usr/share/bootloader/overlays

    # install platform dtbs, but remove upstream kernel dtbs (i.e. without downstream
    # drivers and decent USB support) as these are not required by LibreELEC
    for dtb in arch/${TARGET_KERNEL_ARCH}/boot/dts/*.dtb arch/${TARGET_KERNEL_ARCH}/boot/dts/*/*.dtb; do
      if [ -f ${dtb} ]; then
        cp -v ${dtb} ${INSTALL}/usr/share/bootloader
      fi
    done
    rm -f ${INSTALL}/usr/share/bootloader/bcm283*.dtb
    # duplicated in overlays below
    safe_remove ${INSTALL}/usr/share/bootloader/overlay_map.dtb

    # install overlay dtbs
    for dtb in arch/arm/boot/dts/overlays/*.dtb \
               arch/arm/boot/dts/overlays/*.dtbo; do
      cp ${dtb} ${INSTALL}/usr/share/bootloader/overlays 2>/dev/null || :
    done
    cp -p arch/${TARGET_KERNEL_ARCH}/boot/dts/overlays/README ${INSTALL}/usr/share/bootloader/overlays
  fi
}
