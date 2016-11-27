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
PKG_REV="1"
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
case "$LINUX" in
  amlogic-3.10)
    PKG_VERSION="86c93aa"
    PKG_URL="https://github.com/LibreELEC/linux-amlogic/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="$PKG_NAME-amlogic-$PKG_VERSION*"
    ;;
  amlogic-3.14)
    PKG_VERSION="4bcb3e6"
    PKG_URL="https://github.com/LibreELEC/linux-amlogic/archive/$PKG_VERSION.tar.gz"
    PKG_SOURCE_DIR="$PKG_NAME-amlogic-$PKG_VERSION*"
    ;;
  imx6)
    PKG_VERSION="3.14-mx6-sr"
    PKG_COMMIT="27e61f6"
    PKG_SOURCE_DIR="$PKG_NAME-$PKG_VERSION-$PKG_COMMIT"
    PKG_SOURCE_NAME="$PKG_SOURCE_DIR.tar.xz"
    PKG_URL="$DISTRO_SRC/$PKG_SOURCE_NAME"
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET imx6-status-led imx6-soc-fan"
    ;;
  imx6-4.4-xbian)
    PKG_VERSION="4.4-xbian"
    PKG_COMMIT="20160821-f14907b"
    PKG_SOURCE_DIR="$PKG_NAME-$PKG_VERSION-$PKG_COMMIT"
    PKG_SOURCE_NAME="$PKG_SOURCE_DIR.tar.xz"
    PKG_URL="$DISTRO_SRC/$PKG_SOURCE_NAME"
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET imx6-status-led imx6-soc-fan irqbalanced"
    ;;
  *)
    PKG_VERSION="4.8.11"
    PKG_URL="http://www.kernel.org/pub/linux/kernel/v4.x/$PKG_NAME-$PKG_VERSION.tar.xz"
    ;;
esac

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_HOST="ARCH=$TARGET_KERNEL_ARCH headers_check"

if [ "$TARGET_ARCH" = "x86_64" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET intel-ucode x86-firmware"
fi

if [ "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET mkbootimg:host"
fi

post_patch() {
  if [ -n "$DEVICE" -a -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -n "$DEVICE" -a -f $PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/devices/$DEVICE/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf
  elif [ -f $PKG_DIR/config/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PKG_DIR/config/$PKG_VERSION/$PKG_NAME.$TARGET_ARCH.conf
  else
    KERNEL_CFG_FILE=$PKG_DIR/config/$PKG_NAME.$TARGET_ARCH.conf
  fi

  sed -i -e "s|^HOSTCC[[:space:]]*=.*$|HOSTCC = $ROOT/$TOOLCHAIN/bin/host-gcc|" \
         -e "s|^HOSTCXX[[:space:]]*=.*$|HOSTCXX = $ROOT/$TOOLCHAIN/bin/host-g++|" \
         -e "s|^ARCH[[:space:]]*?=.*$|ARCH = $TARGET_KERNEL_ARCH|" \
         -e "s|^CROSS_COMPILE[[:space:]]*?=.*$|CROSS_COMPILE = $TARGET_PREFIX|" \
         $PKG_BUILD/Makefile

  cp $KERNEL_CFG_FILE $PKG_BUILD/.config
  if [ ! "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    sed -i -e "s|^CONFIG_INITRAMFS_SOURCE=.*$|CONFIG_INITRAMFS_SOURCE=\"$ROOT/$BUILD/image/initramfs.cpio\"|" $PKG_BUILD/.config
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

  # enable different libcec version for imx6 project with kernel 4.4
  # using customized kernel driver
  if [ "$PROJECT" = "imx6" ]; then
    if [ "$LIBCEC_TYPE" = "xbian" -a "$LINUX" = "imx6-4.4-xbian" ]; then
      sed -i -e "s|# CONFIG_MXC_HDMI_CEC is not set|CONFIG_MXC_HDMI_CEC=y|" $PKG_BUILD/.config
      sed -i -e "s|CONFIG_MXC_HDMI_CEC_SR=y||" $PKG_BUILD/.config
    fi
  fi
}

makeinstall_host() {
  make ARCH=$TARGET_KERNEL_ARCH INSTALL_HDR_PATH=dest headers_install
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -R dest/include/* $SYSROOT_PREFIX/usr/include
}

pre_make_target() {
  if [ "$TARGET_ARCH" = "x86_64" ]; then
    # copy some extra firmware to linux tree
    mkdir -p $ROOT/$PKG_BUILD/external-firmware
      cp -a $(get_build_dir x86-firmware)/{amdgpu,amd-ucode,i915,radeon,rtl_nic} $ROOT/$PKG_BUILD/external-firmware

    mkdir -p $ROOT/$PKG_BUILD/external-firmware/intel-ucode
      cp -a $(get_build_dir intel-ucode)/microcode.bin $ROOT/$PKG_BUILD/external-firmware/intel-ucode

    FW_LIST="$(find $ROOT/$PKG_BUILD/external-firmware \( -type f -o -type l \) \( -iname '*.bin' -o -iname '*.fw' \) | sed 's|.*external-firmware/||' | sort | xargs)"
    sed -i "s|CONFIG_EXTRA_FIRMWARE=.*|CONFIG_EXTRA_FIRMWARE=\"${FW_LIST}\"|" $ROOT/$PKG_BUILD/.config
  fi

  make oldconfig

  # regdb
  cp $(get_build_dir wireless-regdb)/db.txt $ROOT/$PKG_BUILD/net/wireless/db.txt

  if [ "$BOOTLOADER" = "u-boot" ]; then
    ( cd $ROOT
      $SCRIPTS/build u-boot
    )
  fi
}

make_target() {
  LDFLAGS="" make modules
  LDFLAGS="" make INSTALL_MOD_PATH=$INSTALL DEPMOD="$ROOT/$TOOLCHAIN/bin/depmod" modules_install
  rm -f $INSTALL/lib/modules/*/build
  rm -f $INSTALL/lib/modules/*/source

  ( cd $ROOT
    rm -rf $ROOT/$BUILD/initramfs
    $SCRIPTS/install initramfs
  )

  if [ "$BOOTLOADER" = "u-boot" -a -n "$KERNEL_UBOOT_EXTRA_TARGET" ]; then
    for extra_target in "$KERNEL_UBOOT_EXTRA_TARGET"; do
      LDFLAGS="" make $extra_target
    done
  fi

  LDFLAGS="" make $KERNEL_TARGET $KERNEL_MAKE_EXTRACMD

  if [ "$BUILD_ANDROID_BOOTIMG" = "yes" ]; then
    LDFLAGS="" mkbootimg --kernel arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET --ramdisk $ROOT/$BUILD/image/initramfs.cpio \
      $ANDROID_BOOTIMG_OPTIONS --output arch/$TARGET_KERNEL_ARCH/boot/boot.img
    mv -f arch/$TARGET_KERNEL_ARCH/boot/boot.img arch/$TARGET_KERNEL_ARCH/boot/$KERNEL_TARGET
  fi
}

makeinstall_target() {
  if [ "$BOOTLOADER" = "u-boot" ]; then
    mkdir -p $INSTALL/usr/share/bootloader
    for dtb in arch/$TARGET_KERNEL_ARCH/boot/dts/*.dtb; do
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
    mkdir -p $INSTALL/lib/modules

    for i in $INITRAMFS_MODULES; do
      module=`find .install_pkg/lib/modules/$(get_module_dir)/kernel -name $i.ko`
      if [ -n "$module" ]; then
        echo $i >> $INSTALL/etc/modules
        cp $module $INSTALL/lib/modules/`basename $module`
      fi
    done
  fi

  if [ "$UVESAFB_SUPPORT" = yes ]; then
    mkdir -p $INSTALL/lib/modules
      uvesafb=`find .install_pkg/lib/modules/$(get_module_dir)/kernel -name uvesafb.ko`
      cp $uvesafb $INSTALL/lib/modules/`basename $uvesafb`
  fi
}

post_install() {
  mkdir -p $INSTALL/lib/firmware/
    ln -sf /storage/.config/firmware/ $INSTALL/lib/firmware/updates

  # bluez looks in /etc/firmware/
    ln -sf /lib/firmware/ $INSTALL/etc/firmware
}
