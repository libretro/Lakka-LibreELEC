# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="busybox"
PKG_VERSION="1.31.0"
PKG_SHA256="0e4925392fd9f3743cc517e031b68b012b24a63b0cf6c1ff03cce7bb3846cc99"
PKG_LICENSE="GPL"
PKG_SITE="http://www.busybox.net"
PKG_URL="http://busybox.net/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain busybox:host hdparm dosfstools e2fsprogs zip unzip usbutils parted procps-ng gptfdisk libtirpc"
PKG_DEPENDS_INIT="toolchain libtirpc"
PKG_LONGDESC="BusyBox combines tiny versions of many common UNIX utilities into a single small executable."
# busybox fails to build with GOLD support enabled with binutils-2.25
PKG_BUILD_FLAGS="-parallel -gold"

# nano text editor
if [ "$NANO_EDITOR" = "yes" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET nano"
fi

# nfs support
if [ "$NFS_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET rpcbind"
fi

if [ "$TARGET_ARCH" = "x86_64" -o "$TARGET_ARCH" = "i386" ]; then
  PKG_DEPENDS_TARGET+=" pciutils"
fi

pre_build_target() {
  PKG_MAKE_OPTS_TARGET="ARCH=$TARGET_ARCH \
                        HOSTCC=$HOST_CC \
                        CROSS_COMPILE=$TARGET_PREFIX \
                        KBUILD_VERBOSE=1 \
                        install"

  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

pre_build_host() {
  PKG_MAKE_OPTS_HOST="ARCH=$TARGET_ARCH CROSS_COMPILE= KBUILD_VERBOSE=1 install"

  mkdir -p $PKG_BUILD/.$HOST_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$HOST_NAME
}

pre_build_init() {
  PKG_MAKE_OPTS_INIT="ARCH=$TARGET_ARCH \
                      HOSTCC=$HOST_CC \
                      CROSS_COMPILE=$TARGET_PREFIX \
                      KBUILD_VERBOSE=1 \
                      install"

  mkdir -p $PKG_BUILD/.$TARGET_NAME-init
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME-init
}

configure_host() {
  cd $PKG_BUILD/.$HOST_NAME
    cp $PKG_DIR/config/busybox-host.conf .config

    # set install dir
    sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$PKG_BUILD/.install_host\"|" .config

    make oldconfig
}

configure_target() {
  cd $PKG_BUILD/.$TARGET_NAME
    find_file_path config/busybox-target.conf
    cp $FOUND_PATH .config

    # set install dir
    sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$INSTALL/usr\"|" .config

    if [ ! "$CRON_SUPPORT" = "yes" ] ; then
      sed -i -e "s|^CONFIG_CROND=.*$|# CONFIG_CROND is not set|" .config
      sed -i -e "s|^CONFIG_FEATURE_CROND_D=.*$|# CONFIG_FEATURE_CROND_D is not set|" .config
      sed -i -e "s|^CONFIG_CRONTAB=.*$|# CONFIG_CRONTAB is not set|" .config
      sed -i -e "s|^CONFIG_FEATURE_CROND_SPECIAL_TIMES=.*$|# CONFIG_FEATURE_CROND_SPECIAL_TIMES is not set|" .config
    fi

    if [ ! "$SAMBA_SUPPORT" = yes ]; then
      sed -i -e "s|^CONFIG_FEATURE_MOUNT_CIFS=.*$|# CONFIG_FEATURE_MOUNT_CIFS is not set|" .config
    fi

    # optimize for size
    CFLAGS=`echo $CFLAGS | sed -e "s|-Ofast|-Os|"`
    CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-Os|"`
    CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/tirpc"

    LDFLAGS="$LDFLAGS -fwhole-program"

    make oldconfig
}

configure_init() {
  cd $PKG_BUILD/.$TARGET_NAME-init
    find_file_path config/busybox-init.conf
    cp $FOUND_PATH .config

    # set install dir
    sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$INSTALL/usr\"|" .config

    # optimize for size
    CFLAGS=`echo $CFLAGS | sed -e "s|-Ofast|-Os|"`
    CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-Os|"`
    CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/tirpc"

    LDFLAGS="$LDFLAGS -fwhole-program"

    make oldconfig
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp -R $PKG_BUILD/.install_host/bin/* $TOOLCHAIN/bin
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    [ $TARGET_ARCH = x86_64 -o $TARGET_ARCH = i386 ] && cp $PKG_DIR/scripts/getedid $INSTALL/usr/bin
    cp $PKG_DIR/scripts/createlog $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/dtfile $INSTALL/usr/bin
    cp $PKG_DIR/scripts/dtname $INSTALL/usr/bin
    cp $PKG_DIR/scripts/dtsoc $INSTALL/usr/bin
    cp $PKG_DIR/scripts/lsb_release $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/apt-get $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/sudo $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/pastebinit $INSTALL/usr/bin/
    ln -sf pastebinit $INSTALL/usr/bin/paste

  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/functions $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/fs-resize $INSTALL/usr/lib/libreelec
    sed -e "s/@DISTRONAME@/$DISTRONAME/g" \
        -i $INSTALL/usr/lib/libreelec/fs-resize

    if listcontains "${FIRMWARE}" "rpi-eeprom"; then
      cp $PKG_DIR/scripts/rpi-flash-firmware $INSTALL/usr/lib/libreelec
    fi

  mkdir -p $INSTALL/etc
    cp $PKG_DIR/config/profile $INSTALL/etc
    cp $PKG_DIR/config/inputrc $INSTALL/etc
    cp $PKG_DIR/config/httpd.conf $INSTALL/etc
    cp $PKG_DIR/config/suspend-modules.conf $INSTALL/etc
  if [ "$DEVICE" == "Switch" ]; then
    sed -i 's/brcmfmac//' $INSTALL/etc/suspend-modules.conf
  fi
  # /etc/fstab is needed by...
    touch $INSTALL/etc/fstab

  # /etc/machine-id, needed by systemd and dbus
    ln -sf /storage/.cache/systemd-machine-id $INSTALL/etc/machine-id

  # /etc/mtab is needed by udisks etc...
    ln -sf /proc/self/mounts $INSTALL/etc/mtab

  # create /etc/hostname
    ln -sf /proc/sys/kernel/hostname $INSTALL/etc/hostname

  # add webroot
    mkdir -p $INSTALL/usr/www
      echo "It works" > $INSTALL/usr/www/index.html

    mkdir -p $INSTALL/usr/www/error
      echo "404" > $INSTALL/usr/www/error/404.html
}

post_install() {
  ROOT_PWD="`$TOOLCHAIN/bin/cryptpw -m sha512 $ROOT_PASSWORD`"

  echo "chmod 4755 $INSTALL/usr/bin/busybox" >> $FAKEROOT_SCRIPT
  echo "chmod 000 $INSTALL/usr/cache/shadow" >> $FAKEROOT_SCRIPT

  add_user root "$ROOT_PWD" 0 0 "Root User" "/storage" "/bin/sh"
  add_group root 0
  add_group users 100

  add_user nobody x 65534 65534 "Nobody" "/" "/bin/sh"
  add_group nogroup 65534

  enable_service shell.service
  enable_service show-version.service
  enable_service var.mount
  enable_service fs-resize.service
  listcontains "${FIRMWARE}" "rpi-eeprom" && enable_service rpi-flash-firmware.service

  # cron support
  if [ "$CRON_SUPPORT" = "yes" ] ; then
    mkdir -p $INSTALL/usr/lib/systemd/system
      cp $PKG_DIR/system.d.opt/cron.service $INSTALL/usr/lib/systemd/system
      enable_service cron.service
    mkdir -p $INSTALL/usr/share/services
      cp -P $PKG_DIR/default.d/*.conf $INSTALL/usr/share/services
      cp $PKG_DIR/system.d.opt/cron-defaults.service $INSTALL/usr/lib/systemd/system
      enable_service cron-defaults.service
  fi
}

makeinstall_init() {
  mkdir -p $INSTALL/bin
    ln -sf busybox $INSTALL/usr/bin/sh
    chmod 4755 $INSTALL/usr/bin/busybox

  mkdir -p $INSTALL/etc
    touch $INSTALL/etc/fstab
    ln -sf /proc/self/mounts $INSTALL/etc/mtab

  #Hack to swap out init, and add early firmware to initramfs for L4T builds
  if [ ${PROJECT} == "L4T" ]; then
    # Copy PROJECT related files to filesystem
    if [ -d "${PROJECT_DIR}/${PROJECT}/initramfs" ]; then
      cp -PR $PROJECT_DIR/$PROJECT/initramfs/* $INSTALL
    fi

    # Copy DEVICE related initramfs files to initramfs filesystem
    if [ -n "$DEVICE" -a -d "$PROJECT_DIR/$PROJECT/devices/$DEVICE/initramfs" ]; then
      cp -PR $PROJECT_DIR/$PROJECT/devices/$DEVICE/initramfs/* $INSTALL
    fi
  fi
  
  if find_file_path initramfs/platform_init; then
    cp ${FOUND_PATH} $INSTALL
    sed -e "s/@BOOT_LABEL@/$DISTRO_BOOTLABEL/g" \
        -e "s/@DISK_LABEL@/$DISTRO_DISKLABEL/g" \
        -i $INSTALL/platform_init
    chmod 755 $INSTALL/platform_init
  fi

  cp $PKG_DIR/scripts/functions $INSTALL
  if [ ! -f $INSTALL/init ]; then
    cp $PKG_DIR/scripts/init $INSTALL
  fi
  sed -e "s/@DISTRONAME@/$DISTRONAME/g" \
      -e "s/@KERNEL_NAME@/$KERNEL_NAME/g" \
      -i $INSTALL/init
  chmod 755 $INSTALL/init
}
