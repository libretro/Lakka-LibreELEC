# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="u-boot"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_DEPENDS_TARGET="toolchain Python3:host swig:host"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."

PKG_STAMP="${UBOOT_SYSTEM} ${UBOOT_TARGET}"

[ -n "${KERNEL_TOOLCHAIN}" ] && PKG_DEPENDS_TARGET+=" gcc-arm-${KERNEL_TOOLCHAIN}:host"

if [ -n "${UBOOT_FIRMWARE}" ]; then
  PKG_DEPENDS_TARGET+=" ${UBOOT_FIRMWARE}"
  PKG_DEPENDS_UNPACK+=" ${UBOOT_FIRMWARE}"
fi

PKG_NEED_UNPACK="${PROJECT_DIR}/${PROJECT}/bootloader"
[ -n "${DEVICE}" ] && PKG_NEED_UNPACK+=" ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/bootloader"

case "${PROJECT}" in
  Amlogic)
    PKG_VERSION="807482107a6d426dbcd6457d9ccf8b3ce6ca887b" # 2021.04-rc2 custodians/u-boot-amlogic-test
    PKG_SHA256="a10430d2c1a1d9e83e66bed342433ddfe4f3d6f16d9fa8b4d4c034b600baffd3"
    PKG_URL="https://github.com/chewitt/u-boot/archive/${PKG_VERSION}.tar.gz"
    PKG_PATCH_DIRS="amlogic"
    ;;
  Rockchip)
    case "${DEVICE}" in
      RK3568)
        PKG_VERSION="5b00db8d3d9d7d7104a3bd0ce175bf62b4f5a089"
        PKG_SHA256="ab88b1a170f2bd17de5925827eb0ab0a8d297bb3b36b803f50ba4ec9b024ed2c"
        PKG_URL="https://github.com/LubanCat/u-boot/archive/${PKG_VERSION}.tar.gz" 
        ;;
      *)
        echo "${DEVICE}" > /home/zerok/game/111.log
        PKG_VERSION="8659d08d2b589693d121c1298484e861b7dafc4f"
        PKG_SHA256="3f9f2bbd0c28be6d7d6eb909823fee5728da023aca0ce37aef3c8f67d1179ec1"
        PKG_URL="https://github.com/rockchip-linux/u-boot/archive/${PKG_VERSION}.tar.gz"
        PKG_PATCH_DIRS="rockchip"
        ;;
    esac
    ;;
  *)
    PKG_VERSION="2021.01"
    PKG_SHA256="b407e1510a74e863b8b5cb42a24625344f0e0c2fc7582d8c866bd899367d0454"
    PKG_URL="http://ftp.denx.de/pub/u-boot/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
    PKG_PATCH_DIRS="default"
    ;;
esac

post_patch() {
  if [ -n "${UBOOT_SYSTEM}" ] && find_file_path bootloader/config; then
    PKG_CONFIG_FILE="${PKG_BUILD}/configs/$(${ROOT}/${SCRIPTS}/uboot_helper ${PROJECT} ${DEVICE} ${UBOOT_SYSTEM} config)"
    if [ -f "${PKG_CONFIG_FILE}" ]; then
      cat ${FOUND_PATH} >> "${PKG_CONFIG_FILE}"
    fi
  fi
}

make_target() {
  if [ -z "${UBOOT_SYSTEM}" ]; then
    echo "UBOOT_SYSTEM must be set to build an image"
    echo "see './scripts/uboot_helper' for more information"
  else
    [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make mrproper
    [ -n "${UBOOT_FIRMWARE}" ] && find_file_path bootloader/firmware && . ${FOUND_PATH}
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm make HOSTCC="${HOST_CC}" HOSTCFLAGS="-I${TOOLCHAIN}/include" HOSTLDFLAGS="${HOST_LDFLAGS}" $(${ROOT}/${SCRIPTS}/uboot_helper ${PROJECT} ${DEVICE} ${UBOOT_SYSTEM} config)
    DEBUG=${PKG_DEBUG} CROSS_COMPILE="${TARGET_KERNEL_PREFIX}" LDFLAGS="" ARCH=arm _python_sysroot="${TOOLCHAIN}" _python_prefix=/ _python_exec_prefix=/ make ${UBOOT_TARGET} HOSTCC="${HOST_CC}" HOSTLDFLAGS="-L${TOOLCHAIN}/lib" HOSTSTRIP="true" CONFIG_MKIMAGE_DTC_PATH="scripts/dtc/dtc"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader

    # Only install u-boot.img et al when building a board specific image
    if [ -n "${UBOOT_SYSTEM}" ]; then
      find_file_path bootloader/install && . ${FOUND_PATH}
    fi

    # Always install the update script
    find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

    # Always install the canupdate script
    if find_file_path bootloader/canupdate.sh; then
      cp -av ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
      sed -e "s/@PROJECT@/${DEVICE:-${PROJECT}}/g" \
          -i ${INSTALL}/usr/share/bootloader/canupdate.sh
    fi
}
