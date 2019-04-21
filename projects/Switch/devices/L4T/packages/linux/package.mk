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
PKG_VERSION="4.9"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="https://nv-tegra.nvidia.com/gitweb/"
L4T_DEPENDS="l4t-kernel linux-nvgpu linux-nvidia l4t-platform-t210-switch tegra t210 common-tegra common-t210"
PKG_DEPENDS_HOST="ccache:host $L4T_DEPENDS"
PKG_DEPENDS_TARGET="toolchain cpio:host kmod:host pciutils xz:host wireless-regdb keyutils $L4T_DEPENDS"
PKG_DEPENDS_INIT="toolchain $L4T_DEPENDS"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="linux"
PKG_SHORTDESC="Linux 4 Tegra for the Switch"
PKG_LONGDESC="Linux 4 Tegra for the Switch"
PKG_SOURCE_DIR="$KERNEL_SOURCE_DIR"
PKG_PATCH_DIRS="$KERNEL_PATCH_DIRS"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

KERNEL_DIR="$PKG_BUILD/kernel/kernel-4.9"

PKG_MAKE_OPTS_HOST="-C $KERNEL_DIR"
PKG_MAKE_OPTS_TARGET="-C $KERNEL_DIR"
PKG_MAKE_OPTS_INIT="-C $KERNEL_DIR"


if [ "$TARGET_KERNEL_ARCH" = "arm64" -a "$TARGET_ARCH" = "arm" ]; then
  if [ "$PROJECT" = "Switch" ]; then
    PKG_DEPENDS_HOST="$PKG_DEPENDS_HOST gcc-linaro-aarch64-linux-gnu:host"
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-linux-gnu:host"
    export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-linux-gnu/bin/:$PATH
    TARGET_PREFIX=aarch64-linux-gnu-
    OLD_CROSS_COMPILE=$CROSS_COMPILE
    export CROSS_COMPILE=$TARGET_PREFIX # necessary for Linux 5
    PKG_MAKE_OPTS_HOST+=" ARCH=$TARGET_ARCH headers_check"
  else
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET gcc-linaro-aarch64-elf:host"
    export PATH=$TOOLCHAIN/lib/gcc-linaro-aarch64-elf/bin/:$PATH
    TARGET_PREFIX=aarch64-elf-
    OLD_CROSS_COMPILE=$CROSS_COMPILE
    export CROSS_COMPILE=$TARGET_PREFIX # necessary for Linux 5
    PKG_MAKE_OPTS_HOST+=" ARCH=$TARGET_ARCH headers_check"
  fi
else
 PKG_MAKE_OPTS_HOST+=" ARCH=$TARGET_KERNEL_ARCH headers_check"
fi

if [ "$PROJECT" = "Switch" ]; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET kernel-firmware openssl:host"
    export C_INCLUDE_PATH="$TOOLCHAIN/include:$C_INCLUDE_PATH"
    export LIBRARY_PATH="$TOOLCHAIN/lib:$LIBRARY_PATH"
fi

patch() {
  # Patches are applied in l4t-kernel
	:
}

unpack() {
  :
}

prepare() {
  if [ -f $KERNEL_DIR/.config ]; then
    return 0
  fi

  echo "Copying required files from all packages..."

  # kernel
  mkdir -p $KERNEL_DIR
	cp -r $PKG_BUILD/../l4t-kernel-*/* $KERNEL_DIR

  # nvgpu
  mkdir -p $PKG_BUILD/kernel/nvgpu
  cp -r $PKG_BUILD/../linux-nvgpu-*/* $PKG_BUILD/kernel/nvgpu

  # nvidia
  mkdir -p $PKG_BUILD/kernel/nvidia
  cp -r $PKG_BUILD/../linux-nvidia-*/* $PKG_BUILD/kernel/nvidia

  # abca
  mkdir -p $PKG_BUILD/hardware/nvidia/platform/t210/switch
  cp -r $PKG_BUILD/../l4t-platform-t210-switch-*/* $PKG_BUILD/hardware/nvidia/platform/t210/switch/

  # tegra
  mkdir -p $PKG_BUILD/hardware/nvidia/soc/tegra/
  cp -r $PKG_BUILD/../tegra-*/* $PKG_BUILD/hardware/nvidia/soc/tegra/

  # t210
  mkdir -p $PKG_BUILD/hardware/nvidia/soc/t210/
  cp -r $PKG_BUILD/../t210-*/* $PKG_BUILD/hardware/nvidia/soc/t210/

  # common-tegra
  mkdir -p $PKG_BUILD/hardware/nvidia/platform/tegra/common/
  cp -r $PKG_BUILD/../common-tegra-*/* $PKG_BUILD/hardware/nvidia/platform/tegra/common/

  # common-t210
  mkdir -p $PKG_BUILD/hardware/nvidia/platform/t210/common/
  cp -r $PKG_BUILD/../common-t210-*/* $PKG_BUILD/hardware/nvidia/platform/t210/common/

  # real post-patch function
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
         -e "s|^CROSS_COMPILE[[:space:]]*?=.*$|CROSS_COMPILE = $TARGET_PREFIX|" \
         $KERNEL_DIR/Makefile

  cp $KERNEL_CFG_FILE $KERNEL_DIR/.config
  if [ ! "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    sed -i -e "s|^CONFIG_INITRAMFS_SOURCE=.*$|CONFIG_INITRAMFS_SOURCE=\"$BUILD/image/initramfs.cpio\"|" $KERNEL_DIR/.config
  fi

  # set default hostname based on $DISTRONAME
    sed -i -e "s|@DISTRONAME@|$DISTRONAME|g" $KERNEL_DIR/.config

  # disable swap support if not enabled
  if [ ! "$SWAP_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_SWAP=.*$|# CONFIG_SWAP is not set|" $KERNEL_DIR/.config
  fi

  # disable nfs support if not enabled
  if [ ! "$NFS_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_NFS_FS=.*$|# CONFIG_NFS_FS is not set|" $KERNEL_DIR/.config
  fi

  # disable cifs support if not enabled
  if [ ! "$SAMBA_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_CIFS=.*$|# CONFIG_CIFS is not set|" $KERNEL_DIR/.config
  fi

  # disable iscsi support if not enabled
  if [ ! "$ISCSI_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_SCSI_ISCSI_ATTRS=.*$|# CONFIG_SCSI_ISCSI_ATTRS is not set|" $KERNEL_DIR/.config
    sed -i -e "s|^CONFIG_ISCSI_TCP=.*$|# CONFIG_ISCSI_TCP is not set|" $KERNEL_DIR/.config
    sed -i -e "s|^CONFIG_ISCSI_BOOT_SYSFS=.*$|# CONFIG_ISCSI_BOOT_SYSFS is not set|" $KERNEL_DIR/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT_FIND=.*$|# CONFIG_ISCSI_IBFT_FIND is not set|" $KERNEL_DIR/.config
    sed -i -e "s|^CONFIG_ISCSI_IBFT=.*$|# CONFIG_ISCSI_IBFT is not set|" $KERNEL_DIR/.config
  fi

  # install extra dts files
  for f in $PROJECT_DIR/$PROJECT/config/*-overlay.dts; do
    [ -f "$f" ] && cp -v $f $KERNEL_DIR/arch/$TARGET_KERNEL_ARCH/boot/dts/overlays || true
  done
  if [ -n "$DEVICE" ]; then
    for f in $PROJECT_DIR/$PROJECT/devices/$DEVICE/config/*-overlay.dts; do
      [ -f "$f" ] && cp -v $f $KERNEL_DIR/arch/$TARGET_KERNEL_ARCH/boot/dts/overlays || true
    done
  fi
}

makeinstall_host() {
  if [ $TARGET_KERNEL_ARCH = "arm64" ] && [ $TARGET_ARCH == "arm"  ]; then
    make -C $KERNEL_DIR ARCH=$TARGET_ARCH INSTALL_HDR_PATH=dest headers_install
  else
    make -C $KERNEL_DIR ARCH=$TARGET_KERNEL_ARCH INSTALL_HDR_PATH=dest headers_install
  fi
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -R $KERNEL_DIR/dest/include/* $SYSROOT_PREFIX/usr/include
}

pre_make_host() {
  prepare
}

pre_make_init() {
  prepare
}

pre_make_target() {
  prepare
  if [ "$TARGET_ARCH" = "x86_64" ]; then
    # copy some extra firmware to linux tree
    mkdir -p $KERNEL_DIR/external-firmware
    cp -a $(get_build_dir kernel-firmware)/{amdgpu,amd-ucode,i915,nvidia,radeon,rtl_nic} $KERNEL_DIR/external-firmware

    cp -a $(get_build_dir intel-ucode)/intel-ucode $KERNEL_DIR/external-firmware

    FW_LIST="$(find $KERNEL_DIR/external-firmware \( -type f -o -type l \) \( -iname '*.bin' -o -iname '*.fw' -o -path '*/intel-ucode/*' \) | sed 's|.*external-firmware/||' | sort | xargs)"
    sed -i "s|CONFIG_EXTRA_FIRMWARE=.*|CONFIG_EXTRA_FIRMWARE=\"${FW_LIST}\"|" $KERNEL_DIR/.config
  fi

  if [ "$PROJECT" = "Switch" ]; then
    mkdir -p $KERNEL_DIR/external-firmware
    cp -a $(get_build_dir kernel-firmware)/{nvidia,brcm,tegra21x_xusb_firmware,tegra210b01_xusb_firmware} $KERNEL_DIR/external-firmware

    FW_LIST="$(find $KERNEL_DIR/external-firmware \( -type f -o -type l \) \( -iname '*.bin' -o -iname '*.txt' -o -iname '*.hcd' -o -iname 'tegra21x_xusb_firmware' -o -iname 'tegra210b01_xusb_firmware' \) | sed 's|.*external-firmware/||' | sort | xargs)"
    sed -i "s|CONFIG_EXTRA_FIRMWARE=.*|CONFIG_EXTRA_FIRMWARE=\"${FW_LIST}\"|" $KERNEL_DIR/.config
  fi

  make -C $KERNEL_DIR olddefconfig # i'm sorry oldconfig but you are too annoying

  # regdb
  cp $(get_build_dir wireless-regdb)/db.txt $KERNEL_DIR/net/wireless/db.txt

  if [ "$BOOTLOADER" = "u-boot" ]; then
    ( cd $ROOT
      $SCRIPTS/build u-boot
    )
  fi
}

make_target() {
  LDFLAGS="" make -C $KERNEL_DIR modules
  LDFLAGS="" make -C $KERNEL_DIR INSTALL_MOD_PATH=$INSTALL/usr DEPMOD="$TOOLCHAIN/bin/depmod" modules_install

  rm -f $INSTALL/usr/lib/modules/*/build
  rm -f $INSTALL/usr/lib/modules/*/source

  ( cd $ROOT
    rm -rf $BUILD/initramfs
    $SCRIPTS/install initramfs
  )

  if [ "$BOOTLOADER" = "u-boot" -a -n "$KERNEL_UBOOT_EXTRA_TARGET" ]; then
    for extra_target in "$KERNEL_UBOOT_EXTRA_TARGET"; do
      LDFLAGS="" make -C $KERNEL_DIR $extra_target
    done
  fi

  LDFLAGS="" make -C $KERNEL_DIR $KERNEL_TARGET $KERNEL_MAKE_EXTRACMD
}

makeinstall_target() {
  if [ "$BOOTLOADER" = "u-boot" ]; then
    mkdir -p $INSTALL/usr/share/bootloader
    for dtb in arch/$TARGET_KERNEL_ARCH/boot/dts/*.dtb; do
      cp $dtb $INSTALL/usr/share/bootloader 2>/dev/null || :
    done
    for dtb in arch/$TARGET_KERNEL_ARCH/boot/dts/*/*.dtb; do
      cp $dtb $INSTALL/usr/share/bootloader 2>/dev/null || :
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
  mkdir -p $INSTALL/usr/lib/firmware/
    ln -sf /storage/.config/firmware/ $INSTALL/usr/lib/firmware/updates

  # bluez looks in /etc/firmware/
    ln -sf /usr/lib/firmware/ $INSTALL/etc/firmware

  export CROSS_COMPILE=$OLD_CROSS_COMPILE
}
