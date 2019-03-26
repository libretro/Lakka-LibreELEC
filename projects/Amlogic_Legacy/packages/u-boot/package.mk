# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="u-boot"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_DEPENDS_TARGET="toolchain gcc-linaro-aarch64-elf:host gcc-linaro-arm-eabi:host"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."

case "$DEVICE" in
  "Odroid_C2")
    PKG_VERSION="095fdbe"
    PKG_URL="https://github.com/hardkernel/u-boot/archive/$PKG_VERSION.tar.gz"
    PKG_SHA256="25ee7c8208d8a97c831b8dd9222ce8984f4a0b8f95dabf9d513c130d04aa05b5"
    ;;
  "KVIM"*)
    PKG_VERSION="ffc14fc"
    PKG_URL="https://github.com/khadas/u-boot/archive/$PKG_VERSION.tar.gz"
    PKG_SHA256="1326126ca7962d314cb522d95e657dbf71966e74c84fb093181910f9e4f2c1fa"
    ;;
  "LePotato")
    PKG_VERSION="a43076c"
    PKG_URL="https://github.com/BayLibre/u-boot/archive/$PKG_VERSION.tar.gz"
    PKG_SHA256="0ae5fd97ba86fcd6cc7b2722580745a0ddbf651ffa0cc0bd188a05a9b668373f"
    ;;
  *)
    PKG_TOOLCHAIN="manual"
    ;;
esac

PKG_NEED_UNPACK="$PROJECT_DIR/$PROJECT/bootloader"
[ -n "$DEVICE" ] && PKG_NEED_UNPACK+=" $PROJECT_DIR/$PROJECT/devices/$DEVICE/bootloader"

post_unpack() {
  sed -i "s|arm-none-eabi-|arm-eabi-|g" $PKG_BUILD/Makefile $PKG_BUILD/arch/arm/cpu/armv8/gx*/firmware/scp_task/Makefile 2>/dev/null || true
}

make_target() {
  if [ -n "$PKG_URL" ]; then
    [ "${BUILD_WITH_DEBUG}" = "yes" ] && PKG_DEBUG=1 || PKG_DEBUG=0
    export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$TOOLCHAIN/lib/gcc-linaro-arm-eabi/bin/:$PATH
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make mrproper
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make $UBOOT_CONFIG
    DEBUG=${PKG_DEBUG} CROSS_COMPILE=aarch64-elf- ARCH=arm CFLAGS="" LDFLAGS="" make HOSTCC="$HOST_CC" HOSTSTRIP="true"
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader

    # Only install u-boot.img et al when building a board specific image
    find_file_path bootloader/install && . ${FOUND_PATH}

    # Always install the update script
    find_file_path bootloader/update.sh && cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader

    # Always install the canupdate script
    if find_file_path bootloader/canupdate.sh; then
      cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader
      sed -e "s/@PROJECT@/${DEVICE:-$PROJECT}/g" \
          -i $INSTALL/usr/share/bootloader/canupdate.sh
    fi

    find_file_path bootloader/boot.ini && cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader
    find_file_path bootloader/config.ini && cp -av ${FOUND_PATH} $INSTALL/usr/share/bootloader

    case "$DEVICE" in
      "Odroid_C2")
        cp -av $PKG_BUILD/u-boot.bin $INSTALL/usr/share/bootloader/u-boot
        ;;
      "KVIM"*|"LePotato")
        cp -av $PKG_BUILD/fip/u-boot.bin.sd.bin $INSTALL/usr/share/bootloader/u-boot
        ;;
    esac
}
