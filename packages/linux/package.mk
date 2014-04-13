################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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
case "$LINUX" in
  imx6)
    PKG_VERSION="cuboxi-592b2d9"
    PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
    ;;
  *)
    PKG_VERSION="3.14"
    PKG_URL="http://www.kernel.org/pub/linux/kernel/v3.x/$PKG_NAME-$PKG_VERSION.tar.xz"
    ;;
esac
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kernel.org"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain cpio:host kmod:host pciutils xz:host wireless-regdb"
PKG_DEPENDS_INIT="toolchain"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_PRIORITY="optional"
PKG_SECTION="linux"
PKG_SHORTDESC="linux26: The Linux kernel 2.6 precompiled kernel binary image and modules"
PKG_LONGDESC="This package contains a precompiled kernel image and the modules."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$PERF_SUPPORT" = "yes" -a "$DEVTOOLS" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET elfutils Python"
fi

PKG_MAKE_OPTS_HOST="ARCH=$TARGET_ARCH headers_check"

if [ "$BOOTLOADER" = "u-boot" ]; then
  KERNEL_IMAGE="$KERNEL_UBOOT_TARGET"
else
  KERNEL_IMAGE="bzImage"
fi

post_patch() {
  if [ -f $PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf ]; then
    KERNEL_CFG_FILE=$PROJECT_DIR/$PROJECT/$PKG_NAME/$PKG_NAME.$TARGET_ARCH.conf
  else
    KERNEL_CFG_FILE=$PKG_DIR/config/$PKG_NAME.$TARGET_ARCH.conf
  fi

  sed -i -e "s|^HOSTCC[[:space:]]*=.*$|HOSTCC = $HOST_CC|" \
         -e "s|^HOSTCXX[[:space:]]*=.*$|HOSTCXX = $HOST_CXX|" \
         -e "s|^ARCH[[:space:]]*?=.*$|ARCH = $TARGET_ARCH|" \
         -e "s|^CROSS_COMPILE[[:space:]]*?=.*$|CROSS_COMPILE = $TARGET_PREFIX|" \
         $PKG_BUILD/Makefile

  cp $KERNEL_CFG_FILE $PKG_BUILD/.config
  sed -i -e "s|^CONFIG_INITRAMFS_SOURCE=.*$|CONFIG_INITRAMFS_SOURCE=\"$ROOT/$BUILD/image/initramfs.cpio\"|" $PKG_BUILD/.config

  # disable PPP support if not enabled
  if [ ! "$PPTP_SUPPORT" = yes ]; then
    sed -i -e "s|^CONFIG_PPP=.*$|# CONFIG_PPP is not set|" $PKG_BUILD/.config
  fi

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

  # copy some extra firmware to linux tree
  cp -R $PKG_DIR/firmware/* $PKG_BUILD/firmware

  make -C $PKG_BUILD oldconfig
}

makeinstall_host() {
  make ARCH=$TARGET_ARCH INSTALL_HDR_PATH=dest headers_install
  mkdir -p $SYSROOT_PREFIX/usr/include
    cp -R dest/include/* $SYSROOT_PREFIX/usr/include
}

pre_make_target() {
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
    $SCRIPTS/install initramfs
  )

  LDFLAGS="" make $KERNEL_IMAGE $KERNEL_MAKE_EXTRACMD

  if [ "$BOOTLOADER" = "u-boot" -a -n "$KERNEL_UBOOT_EXTRA_TARGET" ]; then
    for extra_target in "$KERNEL_UBOOT_EXTRA_TARGET"; do
      LDFLAGS="" make $extra_target
    done
  fi

  if [ "$PERF_SUPPORT" = "yes" -a "$DEVTOOLS" = "yes" ]; then
    ( cd tools/perf

      # dont use some optimizations because of build problems
        strip_lto
        LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`

      export FLAGSGLIBC="$CFLAGS -I$SYSROOT_PREFIX/usr/include"
      export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include"
      export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/lib -L$SYSROOT_PREFIX/usr/lib"

      make CROSS_COMPILE="$TARGET_PREFIX" \
           ARCH="$TARGET_ARCH" \
           V=1 \
           DEBUG=false \
           NLS=false \
           NO_GTK2=true \
           NO_LIBELF=false \
           NO_LIBPERL=true \
           NO_LIBPYTHON=false \
           PYTHON=$SYSROOT_PREFIX/usr/bin/python \
           WERROR=0 \
           NO_SLANG=1 \
           EXTRA_CFLAGS="$CFLAGS"
    )
  fi
}

makeinstall_target() {
  if [ "$BOOTLOADER" = "u-boot" ]; then
    mkdir -p $INSTALL/usr/share/u-boot
    for dtb in arch/arm/boot/dts/*.dtb; do
      cp $dtb $INSTALL/usr/share/u-boot
    done
  fi

  if [ "$PERF_SUPPORT" = "yes" -a "$DEVTOOLS" = "yes" ]; then
    mkdir -p $INSTALL/usr/bin
      cp -P tools/perf/perf $INSTALL/usr/bin/

    mkdir -p $INSTALL/usr/libexec/perf-core/scripts/python/
      cp -P tools/perf/perf-archive $INSTALL/usr/libexec/perf-core/
      cp -rP tools/perf/scripts/python/* $INSTALL/usr/libexec/perf-core/scripts/python/
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
  mkdir -p $INSTALL/etc/modprobe.d
    cp $PKG_DIR/modprobe.d/*.conf $INSTALL/etc/modprobe.d

  enable_service cpufreq-threshold.service
}
