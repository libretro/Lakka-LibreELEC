################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="u-boot"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="http://www.denx.de/wiki/U-Boot"
PKG_SOURCE_DIR="u-boot-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain dtc:host Python:host"
PKG_SECTION="tools"
PKG_SHORTDESC="u-boot: Universal Bootloader project"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems, used as the default boot loader by several board vendors. It is intended to be easy to port and to debug, and runs on many supported architectures, including PPC, ARM, MIPS, x86, m68k, NIOS, and Microblaze."
PKG_AUTORECONF="no"
PKG_IS_KERNEL_PKG="yes"

case $BOARD in
  ROC-RK3328-CC|OdroidN1)
    PKG_VERSION="8659d08d2b589693d121c1298484e861b7dafc4f"
    PKG_SHA256="3f9f2bbd0c28be6d7d6eb909823fee5728da023aca0ce37aef3c8f67d1179ec1"
    PKG_URL="https://github.com/rockchip-linux/u-boot/archive/$PKG_VERSION.tar.gz"
    PKG_PATCH_DIRS="rockchip"
    ;;
  *)
    PKG_VERSION="2018.09"
    PKG_SHA256="839bf23cfe8ce613a77e583a60375179d0ad324e92c82fbdd07bebf0fd142268"
    PKG_URL="http://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
    PKG_PATCH_DIRS="mainline"
esac

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-elf:host"
  export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$PATH
  TARGET_PREFIX=aarch64-elf-
fi

if [ "$UBOOT_SOC" = "rk3328" ] || [ "$UBOOT_SOC" = "rk3399" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET rkbin"
  PKG_NEED_UNPACK="$(get_pkg_directory rkbin)"
fi

pre_configure_target() {
  if [ -z "$UBOOT_CONFIG" ]; then
    echo "Please add UBOOT_CONFIG to your project or device options file, aborting."
    exit 1
  elif [ -z "$UBOOT_SOC" ]; then
    echo "Please add UBOOT_SOC to your project or device options file, aborting."
    exit 1
  fi
}

make_target() {
  CROSS_COMPILE="$TARGET_PREFIX" CFLAGS="" LDFLAGS="" ARCH=arm make mrproper
  CROSS_COMPILE="$TARGET_PREFIX" CFLAGS="" LDFLAGS="" ARCH=arm make $UBOOT_CONFIG
  CROSS_COMPILE="$TARGET_PREFIX" CFLAGS="" LDFLAGS="" ARCH=arm make HOSTCC="$HOST_CC" HOSTSTRIP="true"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader
    cp -PRv $PKG_DIR/scripts/update.sh $INSTALL/usr/share/bootloader

 if [ "$UBOOT_SOC" = "rk3288" ]; then
    tools/mkimage \
      -n $UBOOT_SOC \
      -T rksd \
      -d spl/u-boot-spl-dtb.bin \
      idbloader.img
    cat u-boot-dtb.bin >> idbloader.img

    cp -PRv idbloader.img $INSTALL/usr/share/bootloader
  elif [ "$UBOOT_SOC" = "rk3328" ] ||[ "$UBOOT_SOC" = "rk3399" ] ; then

      case "$UBOOT_SOC" in
        rk3328)
          DATAFILE="$PROJECT_DIR/$PROJECT/bootloader/rk3328_ddr_933MHz_v1.10.bin"
          LOADER="$(get_build_dir rkbin)/rk33/rk3328_miniloader_v2.49.bin"
          BL31="$(get_build_dir rkbin)/rk33/rk3328_bl31_v1.34.bin"
          ;;
        rk3399)
          DATAFILE="$(get_build_dir rkbin)/rk33/rk3399_ddr_800MHz_v1.14.bin"
          LOADER="$(get_build_dir rkbin)/rk33/rk3399_miniloader_v1.15.bin"
          BL31="$(get_build_dir rkbin)/rk33/rk3399_bl31_v1.18.elf"
          ;;
      esac

    $(get_build_dir rkbin)/tools/loaderimage --pack --uboot u-boot-dtb.bin uboot.img 0x200000

    tools/mkimage \
      -n $UBOOT_SOC \
      -T rksd \
      -d "$DATAFILE" \
      idbloader.img

    cat "$LOADER" >> idbloader.img

    cat >trust.ini <<EOF
[BL30_OPTION]
SEC=0
[BL31_OPTION]
SEC=1
PATH=$BL31
ADDR=0x00010000
[BL32_OPTION]
SEC=0
[BL33_OPTION]
SEC=0
[OUTPUT]
PATH=trust.img
EOF
    $(get_build_dir rkbin)/tools/trust_merger --verbose trust.ini

    cp -PRv idbloader.img $INSTALL/usr/share/bootloader
    cp -PRv uboot.img $INSTALL/usr/share/bootloader
    cp -PRv trust.img $INSTALL/usr/share/bootloader
  fi
}
