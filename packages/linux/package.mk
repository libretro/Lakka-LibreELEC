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

PKG_NAME="linux"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kernel.org"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain cpio:host kmod:host pciutils xz:host wireless-regdb keyutils"
PKG_DEPENDS_INIT="toolchain"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="linux"
PKG_SHORTDESC="linux26: The Linux kernel 2.6 precompiled kernel binary image and modules"
PKG_LONGDESC="This package contains a precompiled kernel image and the modules."
PKG_IS_KERNEL_PKG="yes"

case "$LINUX" in
  amlogic-3.10)
    PKG_VERSION="24a7272"
    PKG_SHA256="7219a9d0ba7b3ded590f335671671431b15fff64dc05b83565e2867c4f7b2e60"
    PKG_URL="https://github.com/LibreELEC/linux-amlogic/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="$PKG_NAME-amlogic-$PKG_VERSION*"
    PKG_PATCH_DIRS="amlogic-3.10"
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET aml-dtbtools:host"
    ;;
  amlogic-3.14)
    PKG_VERSION="c855778"
    PKG_SHA256="c6a2066e4a1052503a798ae7bf10aaf551466989fe909b130da8bdf99eb59b1a"
    PKG_URL="https://github.com/LibreELEC/linux-amlogic/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="$PKG_NAME-amlogic-$PKG_VERSION*"
    PKG_PATCH_DIRS="amlogic-3.14"
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET aml-dtbtools:host"
    ;;
  *)
    PKG_VERSION="4.14.10"
    PKG_SHA256="86baf1374ca003bdd9a43cae7f59cec02b455a6c38c3705aa46b2b68d91ed110"
    PKG_URL="https://www.kernel.org/pub/linux/kernel/v4.x/$PKG_NAME-$PKG_VERSION.tar.xz"
    PKG_PATCH_DIRS="default"
    ;;
esac

if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  PKG_DEPENDS_HOST="$PKG_DEPENDS_HOST gcc-linaro-aarch64-linux-gnu:host"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-linux-gnu:host"
  PKG_TARGET_PREFIX=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/aarch64-linux-gnu-
  HEADERS_ARCH=$TARGET_ARCH
else
  PKG_TARGET_PREFIX=$TARGET_PREFIX
fi

PKG_MAKE_OPTS_HOST="ARCH=${HEADERS_ARCH:-$TARGET_KERNEL_ARCH} headers_check"

if [ "$TARGET_ARCH" = "x86_64" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET intel-ucode:host kernel-firmware"
fi

if [ "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mkbootimg:host"
fi

post_patch() {
  CFG_FILE="$PKG_NAME.${TARGET_PATCH_ARCH:-$TARGET_ARCH}.conf"
  if [ -n "$DEVICE" -a -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_VERSION/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_VERSION/$CFG_FILE
  elif [ -n "$DEVICE" -a -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$LINUX/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$LINUX/$CFG_FILE
  elif [ -n "$DEVICE" -a -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$CFG_FILE
  elif [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_VERSION/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_VERSION/$CFG_FILE
  elif [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$LINUX/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$LINUX/$CFG_FILE
  elif [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$CFG_FILE
  elif [ -f $PKG_DIR/config/$PKG_VERSION/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PKG_DIR/config/$PKG_VERSION/$CFG_FILE
  elif [ -f $PKG_DIR/config/$LINUX/$CFG_FILE ]; then
    KERNEL_CFG_FILE=$PKG_DIR/config/$LINUX/$CFG_FILE
  else
    KERNEL_CFG_FILE=$PKG_DIR/config/$CFG_FILE
  fi

  sed -i -e "s|^HOSTCC[[:space:]]*=.*$|HOSTCC = $TOOLCHAIN/bin/host-gcc|" \
         -e "s|^HOSTCXX[[:space:]]*=.*$|HOSTCXX = $TOOLCHAIN/bin/host-g++|" \
         -e "s|^ARCH[[:space:]]*?=.*$|ARCH = $TARGET_KERNEL_ARCH|" \
         -e "s|^CROSS_COMPILE[[:space:]]*?=.*$|CROSS_COMPILE = $PKG_TARGET_PREFIX|" \
         $PKG_BUILD/Makefile

  cp $KERNEL_CFG_FILE $PKG_BUILD/.config
  if [ ! "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    sed -i -e "s|^CONFIG_INITRAMFS_SOURCE=.*$|CONFIG_INITRAMFS_SOURCE=\"$BUILD/image/initramfs.cpio\"|" $PKG_BUILD/.config
    sed -i -e '/^CONFIG_INITRAMFS_SOURCE=*./ a CONFIG_INITRAMFS_ROOT_UID=0\nCONFIG_INITRAMFS_ROOT_GID=0' $PKG_BUILD/.config
  fi

  # set default hostname based on $DISTRONAME
    sed -i -e "s|@DISTRONAME@|$DISTRONAME|g" $PKG_BUILD/.config

  # disable swap support if not enabled
  if [ ! "$SWAP_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_SWAP=.*$|# CONFIG_SWAP is not set|" $PKG_BUILD/.config
  fi

  # disable nfs support if not enabled
  if [ ! "$NFS_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_NFS_FS=.*$|# CONFIG_NFS_FS is not set|" $PKG_BUILD/.config
  fi

  # disable cifs support if not enabled
  if [ ! "$SAMBA_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_CIFS=.*$|# CONFIG_CIFS is not set|" $PKG_BUILD/.config
  fi

  # disable iscsi support if not enabled
  if [ ! "$ISCSI_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_SCSI_ISCSI_ATTRS=.*$|# CONFIG_SCSI_ISCSI_ATTRS is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_TCP=.*$|# CONFIG_ISCSI_TCP is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_BOOT_SYSFS=.*$|# CONFIG_ISCSI_BOOT_SYSFS is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT_FIND=.*$|# CONFIG_ISCSI_IBFT_FIND is not set|" $PKG_BUILD/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT=.*$|# CONFIG_ISCSI_IBFT is not set|" $PKG_BUILD/.config
  fi

  # install extra dts files
  for f in $PROJECT_DIR/$PROJECT/config/*-overlay.dts; do
    [ -f "$f" ] && cp -v $f $PKG_BUILD/arch/$TARGET_KERNEL_ARCH/boot/dts/overlays || true
  done
  if [ -n "$DEVICE" ]; then
    for f in $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/*-overlay.dts; do
      [ -f "$f" ] && cp -v $f $PKG_BUILD/arch/$TARGET_KERNEL_ARCH/boot/dts/overlays || true
    done
  fi
}

makeinstall_host() {
  make ARCH=${HEADERS_ARCH:-$TARGET_KERNEL_ARCH} INSTALL_HDR_PATH=dest headers_install
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -R dest/include/* $SYSROOT_PREFIX/usr/include
}

pre_make_target() {
  if [ "$TARGET_ARCH" = "x86_64" ]; then
    # copy some extra firmware to linux tree
    mkdir -p $PKG_BUILD/external-firmware
      cp -a $(get_build_dir kernel-firmware)/{amdgpu,amd-ucode,i915,radeon,e100,rtl_nic} $PKG_BUILD/external-firmware

    cp -a $(get_build_dir intel-ucode)/intel-ucode $PKG_BUILD/external-firmware

    FW_LIST="$(find $PKG_BUILD/external-firmware \( -type f -o -type l \) \( -iname '*.bin' -o -iname '*.fw' -o -path '*/intel-ucode/*' \) | sed 's|.*external-firmware/||' | sort | xargs)"
    sed -i "s|CONFIG_EXTRA_FIRMWARE=.*|CONFIG_EXTRA_FIRMWARE=\"${FW_LIST}\"|" $PKG_BUILD/.config
  fi

  make oldconfig

  # regdb
  cp $(get_build_dir wireless-regdb)/db.txt $PKG_BUILD/net/wireless/db.txt
}

make_target() {
  LDFLAGS="" make modules
  LDFLAGS="" make INSTALL_MOD_PATH=$INSTALL/$(get_kernel_overlay_dir) DEPMOD="$TOOLCHAIN/bin/depmod" modules_install
  rm -f $INSTALL/$(get_kernel_overlay_dir)/lib/modules/*/build
  rm -f $INSTALL/$(get_kernel_overlay_dir)/lib/modules/*/source

  ( cd $ROOT
    rm -rf $BUILD/initramfs
    $SCRIPTS/install initramfs
  )

  if [ "$BOOTLOADER" = "u-boot" -a -n "$KERNEL_UBOOT_EXTRA_TARGET" ]; then
    for extra_target in "$KERNEL_UBOOT_EXTRA_TARGET"; do
      LDFLAGS="" make $extra_target
    done
  fi

  LDFLAGS="" make $KERNEL_TARGET $KERNEL_MAKE_EXTRACMD

  if [ "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    DTB_BLOBS=($(ls arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/*.dtb 2>/dev/null || true))
    DTB_BLOBS_COUNT="${#DTB_BLOBS[@]}"
    DTB_BLOB_OUTPUT="arch/$TARGET_KERNEL_ARCH/boot/dtb.img"
    ANDROID_BOOTIMG_SECOND="--second $DTB_BLOB_OUTPUT"

    if [ "$DTB_BLOBS_COUNT" -gt 1 ]; then
      $TOOLCHAIN/bin/dtbTool -o arch/$TARGET_KERNEL_ARCH/boot/dtb.img -p scripts/dtc/ arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/
    elif [ "$DTB_BLOBS_COUNT" -eq 1 ]; then
      cp -PR $DTB_BLOBS $DTB_BLOB_OUTPUT
    else
      ANDROID_BOOTIMG_SECOND=""
    fi

    LDFLAGS="" mkbootimg --kernel arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET --ramdisk $BUILD/image/initramfs.cpio \
      $ANDROID_BOOTIMG_SECOND $ANDROID_BOOTIMG_OPTIONS --output arch/$TARGET_KERNEL_ARCH/boot/boot.img

    mv -f arch/$TARGET_KERNEL_ARCH/boot/boot.img arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET

  fi
}

makeinstall_target() {
  if [ "$BOOTLOADER" = "u-boot" ]; then
    mkdir -p $INSTALL/usr/share/bootloader
    for dtb in arch/$TARGET_KERNEL_ARCH/boot/dts/*.dtb arch/$TARGET_KERNEL_ARCH/boot/dts/*/*.dtb; do
      if [ -f $dtb ]; then
        cp -v $dtb $INSTALL/usr/share/bootloader
      fi
    done
    if [ -d arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic -a -f "arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$KERNEL_UBOOT_EXTRA_TARGET" ]; then
      cp "arch/$TARGET_KERNEL_ARCH/boot/dts/amlogic/$KERNEL_UBOOT_EXTRA_TARGET" $INSTALL/usr/share/bootloader/dtb.img 2>/dev/null || :
    fi
  elif [ "$BOOTLOADER" = "bcm2835-bootloader" ]; then
    mkdir -p $INSTALL/usr/share/bootloader/overlays
    cp -p arch/$TARGET_KERNEL_ARCH/boot/dts/*.dtb $INSTALL/usr/share/bootloader
    for dtb in arch/$TARGET_KERNEL_ARCH/boot/dts/overlays/*.dtbo; do
      cp $dtb $INSTALL/usr/share/bootloader/overlays 2>/dev/null || :
    done
    cp -p arch/$TARGET_KERNEL_ARCH/boot/dts/overlays/README $INSTALL/usr/share/bootloader/overlays
  fi
}

make_init() {
 : # reuse make_target()
}

makeinstall_init() {
  if [ -n "$INITRAMFS_MODULES" ]; then
    mkdir -p $INSTALL/etc
    mkdir -p $INSTALL/usr/lib/modules

    for i in $INITRAMFS_MODULES; do
      module=`find .install_pkg/$(get_full_module_dir)/kernel -name $i.ko`
      if [ -n "$module" ]; then
        echo $i >> $INSTALL/etc/modules
        cp $module $INSTALL/usr/lib/modules/`basename $module`
      fi
    done
  fi

  if [ "$UVESAFB_SUPPORT" = yes ]; then
    mkdir -p $INSTALL/usr/lib/modules
      uvesafb=`find .install_pkg/$(get_full_module_dir)/kernel -name uvesafb.ko`
      cp $uvesafb $INSTALL/usr/lib/modules/`basename $uvesafb`
  fi
}

post_install() {
  mkdir -p $INSTALL/$(get_full_firmware_dir)/
    ln -sf /storage/.config/firmware/ $INSTALL/$(get_full_firmware_dir)/updates

  # bluez looks in /etc/firmware/
    ln -sf /$(get_full_firmware_dir)/ $INSTALL/etc/firmware
}
