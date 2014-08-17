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

PKG_NAME="busybox"
PKG_VERSION="1.22.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.busybox.net"
PKG_URL="http://busybox.net/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain busybox:host hdparm dosfstools e2fsprogs zip unzip pciutils usbutils parted"
PKG_DEPENDS_INIT="toolchain"
PKG_NEED_UNPACK="packages/sysutils/busybox/config/*"
PKG_PRIORITY="required"
PKG_SECTION="system"
PKG_SHORTDESC="BusyBox: The Swiss Army Knife of Embedded Linux"
PKG_LONGDESC="BusyBox combines tiny versions of many common UNIX utilities into a single small executable. It provides replacements for most of the utilities you usually find in GNU fileutils, shellutils, etc. The utilities in BusyBox generally have fewer options than their full-featured GNU cousins; however, the options that are included provide the expected functionality and behave very much like their GNU counterparts. BusyBox provides a fairly complete environment for any small or embedded system."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_HOST="ARCH=$TARGET_ARCH CROSS_COMPILE= KBUILD_VERBOSE=1 install"
PKG_MAKE_OPTS_TARGET="ARCH=$TARGET_ARCH \
                      HOSTCC=$HOST_CC \
                      CROSS_COMPILE=$TARGET_PREFIX \
                      KBUILD_VERBOSE=1 \
                      install"
PKG_MAKE_OPTS_INIT="ARCH=$TARGET_ARCH \
                    HOSTCC=$HOST_CC \
                    CROSS_COMPILE=$TARGET_PREFIX \
                    KBUILD_VERBOSE=1 \
                    install"

# nano text editor
  if [ "$NANO_EDITOR" = "yes" ]; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET nano"
  fi

# nfs support
if [ "$NFS_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET rpcbind"
fi

if [ -f $PROJECT_DIR/$PROJECT/busybox/busybox-target.conf ]; then
  BUSYBOX_CFG_FILE_TARGET=$PROJECT_DIR/$PROJECT/busybox/busybox-target.conf
else
  BUSYBOX_CFG_FILE_TARGET=$PKG_DIR/config/busybox-target.conf
fi

if [ -f $PROJECT_DIR/$PROJECT/busybox/busybox-init.conf ]; then
  BUSYBOX_CFG_FILE_INIT=$PROJECT_DIR/$PROJECT/busybox/busybox-init.conf
else
  BUSYBOX_CFG_FILE_INIT=$PKG_DIR/config/busybox-init.conf
fi

pre_build_target() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME
}

pre_build_host() {
  mkdir -p $PKG_BUILD/.$HOST_NAME
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$HOST_NAME
}

pre_build_init() {
  mkdir -p $PKG_BUILD/.$TARGET_NAME-init
  cp -RP $PKG_BUILD/* $PKG_BUILD/.$TARGET_NAME-init
}

configure_host() {
  cd $ROOT/$PKG_BUILD/.$HOST_NAME
    cp $PKG_DIR/config/busybox-host.conf .config

    # set install dir
    sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$ROOT/$PKG_BUILD/.install_host\"|" .config

    make oldconfig
}

configure_target() {
  cd $ROOT/$PKG_BUILD/.$TARGET_NAME
    cp $BUSYBOX_CFG_FILE_TARGET .config

    # set install dir
    sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$INSTALL\"|" .config

    if [ ! "$CRON_SUPPORT" = "yes" ] ; then
      sed -i -e "s|^CONFIG_CROND=.*$|# CONFIG_CROND is not set|" .config
      sed -i -e "s|^CONFIG_FEATURE_CROND_D=.*$|# CONFIG_FEATURE_CROND_D is not set|" .config
      sed -i -e "s|^CONFIG_CRONTAB=.*$|# CONFIG_CRONTAB is not set|" .config
    fi

    if [ ! "$NFS_SUPPORT" = yes ]; then
      sed -i -e "s|^CONFIG_FEATURE_MOUNT_NFS=.*$|# CONFIG_FEATURE_MOUNT_NFS is not set|" .config
    fi

    if [ ! "$SAMBA_SUPPORT" = yes ]; then
      sed -i -e "s|^CONFIG_FEATURE_MOUNT_CIFS=.*$|# CONFIG_FEATURE_MOUNT_CIFS is not set|" .config
    fi

    # optimize for size
    CFLAGS=`echo $CFLAGS | sed -e "s|-Ofast|-Os|"`
    CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-Os|"`

    LDFLAGS="$LDFLAGS -fwhole-program"

    make oldconfig
}

configure_init() {
  cd $ROOT/$PKG_BUILD/.$TARGET_NAME-init
    cp $BUSYBOX_CFG_FILE_INIT .config

    # set install dir
    sed -i -e "s|^CONFIG_PREFIX=.*$|CONFIG_PREFIX=\"$INSTALL\"|" .config

    # optimize for size
    CFLAGS=`echo $CFLAGS | sed -e "s|-Ofast|-Os|"`
    CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-Os|"`

    LDFLAGS="$LDFLAGS -fwhole-program"

    make oldconfig
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp -R $ROOT/$PKG_BUILD/.install_host/bin/* $ROOT/$TOOLCHAIN/bin
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp $PKG_DIR/scripts/createlog $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/lsb_release $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/apt-get $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/passwd $INSTALL/usr/bin/
    cp $PKG_DIR/scripts/sudo $INSTALL/usr/bin/
    ln -sf /bin/busybox $INSTALL/usr/bin/env          #/usr/bin/env is needed for most python scripts
    cp $PKG_DIR/scripts/pastebinit $INSTALL/usr/bin/
    ln -sf pastebinit $INSTALL/usr/bin/paste

  mkdir -p $INSTALL/usr/lib/openelec
    cp $PKG_DIR/scripts/fs-resize $INSTALL/usr/lib/openelec

  mkdir -p $INSTALL/etc
    cp $PKG_DIR/config/profile $INSTALL/etc
    cp $PKG_DIR/config/inputrc $INSTALL/etc
    cp $PKG_DIR/config/httpd.conf $INSTALL/etc
    cp $PKG_DIR/config/suspend-modules.conf $INSTALL/etc

  mkdir -p $INSTALL/usr/config/sysctl.d
    cp $PKG_DIR/config/transmission.conf $INSTALL/usr/config/sysctl.d

  # /etc/fstab is needed by...
    touch $INSTALL/etc/fstab

  # /etc/machine-id, needed by systemd and dbus
    ln -sf /run/machine-id $INSTALL/etc/machine-id

  # /etc/hosts must be writeable
    ln -sf /var/cache/hosts $INSTALL/etc/hosts

  # /etc/mtab is needed by udisks etc...
    ln -sf /proc/self/mounts $INSTALL/etc/mtab

  # create /etc/hostname
    ln -sf /proc/sys/kernel/hostname $INSTALL/etc/hostname

  # systemd wants /usr/bin/mkdir
    mkdir -p $INSTALL/usr/bin
      ln -sf /bin/busybox $INSTALL/usr/bin/mkdir

  # add webroot
    mkdir -p $INSTALL/usr/www
      echo "It works" > $INSTALL/usr/www/index.html

    mkdir -p $INSTALL/usr/www/error
      echo "404" > $INSTALL/usr/www/error/404.html
}

post_install() {
  ROOT_PWD="`$ROOT/$TOOLCHAIN/bin/cryptpw -m sha512 $ROOT_PASSWORD`"

  echo "chmod 4755 $INSTALL/bin/busybox" >> $FAKEROOT_SCRIPT
  echo "chmod 000 $INSTALL/etc/shadow" >> $FAKEROOT_SCRIPT

  add_user root "$ROOT_PWD" 0 0 "Root User" "/storage" "/bin/sh"
  add_group root 0
  add_group users 100

  enable_service debug-shell.service
  enable_service shell.service
  enable_service show-version.service
  enable_service var.mount
  enable_service var-log-debug.service
  enable_service fs-resize.service

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
    ln -sf busybox $INSTALL/bin/sh
    chmod 4755 $INSTALL/bin/busybox

  mkdir -p $INSTALL/etc
    touch $INSTALL/etc/fstab
    ln -sf /proc/self/mounts $INSTALL/etc/mtab

  cp $PKG_DIR/scripts/init $INSTALL
  chmod 755 $INSTALL/init
}
