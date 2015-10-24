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

PKG_NAME="systemd"
PKG_VERSION="219"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/systemd"
PKG_URL="http://www.freedesktop.org/software/systemd/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain libcap kmod util-linux"
PKG_PRIORITY="required"
PKG_SECTION="system"
PKG_SHORTDESC="systemd: a system and session manager"
PKG_LONGDESC="systemd is a system and session manager for Linux, compatible with SysV and LSB init scripts. systemd provides aggressive parallelization capabilities, uses socket and D-Bus activation for starting services, offers on-demand starting of daemons, keeps track of processes using Linux cgroups, supports snapshotting and restoring of the system state, maintains mount and automount points and implements an elaborate transactional dependency-based service control logic. It can work as a drop-in replacement for sysvinit."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_have_decl_IFLA_BOND_AD_INFO=no \
                           ac_cv_have_decl_IFLA_BRPORT_UNICAST_FLOOD=no \
                           KMOD=/usr/bin/kmod \
                           --disable-nls \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-gtk-doc-pdf \
                           --disable-python-devel \
                           --disable-python-devel \
                           --disable-dbus \
                           --disable-utmp \
                           --disable-compat-libs \
                           --disable-coverage \
                           --enable-kmod \
                           --disable-xkbcommon \
                           --enable-blkid \
                           --disable-seccomp \
                           --disable-ima \
                           --disable-chkconfig \
                           --disable-selinux \
                           --disable-apparmor \
                           --disable-xz \
                           --disable-zlib \
                           --disable-bzip2 \
                           --disable-lz4 \
                           --disable-pam \
                           --disable-acl \
                           --disable-smack \
                           --disable-gcrypt \
                           --disable-audit \
                           --disable-elfutils \
                           --disable-libcryptsetup \
                           --disable-qrencode \
                           --disable-microhttpd \
                           --disable-gnutls \
                           --disable-libcurl \
                           --disable-libidn \
                           --disable-libiptc \
                           --disable-binfmt \
                           --disable-vconsole \
                           --disable-bootchart \
                           --disable-quotacheck \
                           --enable-tmpfiles \
                           --disable-sysusers \
                           --disable-firstboot \
                           --disable-randomseed \
                           --disable-backlight \
                           --disable-rfkill \
                           --enable-logind \
                           --disable-machined \
                           --disable-importd \
                           --disable-hostnamed \
                           --disable-timedated \
                           --disable-timesyncd \
                           --disable-localed \
                           --disable-coredump \
                           --disable-polkit \
                           --disable-resolved \
                           --disable-networkd \
                           --disable-efi \
                           --disable-terminal \
                           --disable-kdbus \
                           --disable-myhostname \
                           --disable-gudev \
                           --enable-hwdb \
                           --disable-manpages \
                           --disable-hibernate \
                           --disable-ldconfig \
                           --enable-split-usr \
                           --disable-tests \
                           --without-python \
                           --with-sysvinit-path= \
                           --with-sysvrcnd-path= \
                           --with-tty-gid=5 \
                           --with-dbuspolicydir=/etc/dbus-1/system.d \
                           --with-dbussessionservicedir=/usr/share/dbus-1/services \
                           --with-dbussystemservicedir=/usr/share/dbus-1/system-services \
                           --with-dbusinterfacedir=/usr/share/dbus-1/interfaces \
                           --with-rootprefix=/usr \
                           --with-rootlibdir=/lib"

post_makeinstall_target() {
  # remove unneeded stuff
  rm -rf $INSTALL/etc/systemd/system
  rm -rf $INSTALL/etc/xdg
  rm  -f $INSTALL/usr/bin/kernel-install
  rm -rf $INSTALL/usr/lib/kernel/install.d
  rm -rf $INSTALL/usr/lib/rpm
  rm -rf $INSTALL/usr/lib/systemd/user
  rm -rf $INSTALL/usr/lib/tmpfiles.d/etc.conf
  rm -rf $INSTALL/usr/share/factory
  rm -rf $INSTALL/usr/share/zsh

  # clean up hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-OUI.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-acpi-vendor.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-bluetooth-vendor-product.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-net-ifname.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-sdio-classes.hwdb
  rm -f $INSTALL/usr/lib/udev/hwdb.d/20-sdio-vendor-model.hwdb

  # remove Network adaper renaming rule, this is confusing
  rm -rf $INSTALL/usr/lib/udev/rules.d/80-net-setup-link.rules

  # remove debug-shell.service, we install our own
  rm -rf $INSTALL/usr/lib/systemd/system/debug-shell.service

  # remove getty units, we dont want a console
  rm -rf $INSTALL/usr/lib/systemd/system/autovt@.service
  rm -rf $INSTALL/usr/lib/systemd/system/console-getty.service
  rm -rf $INSTALL/usr/lib/systemd/system/console-shell.service
  rm -rf $INSTALL/usr/lib/systemd/system/container-getty@.service
  rm -rf $INSTALL/usr/lib/systemd/system/getty.target
  rm -rf $INSTALL/usr/lib/systemd/system/getty@.service
  rm -rf $INSTALL/usr/lib/systemd/system/serial-getty@.service
  rm -rf $INSTALL/usr/lib/systemd/system/*.target.wants/getty.target

  # remove other notused or nonsense stuff (our /etc is ro)
  rm -rf $INSTALL/usr/lib/systemd/systemd-update-done
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-update-done.service
  rm -rf $INSTALL/usr/lib/systemd/system/*.target.wants/systemd-update-done.service

  # remove systemd-udev-hwdb-update. we have own hwdb.service
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-udev-hwdb-update.service
  rm -rf $INSTALL/usr/lib/systemd/system/*.target.wants/systemd-udev-hwdb-update.service

  # remove nspawn
  rm -rf $INSTALL/usr/bin/systemd-nspawn
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-nspawn@.service

  # remove genetators/catalog
  rm -rf $INSTALL/usr/lib/systemd/system-generators
  rm -rf $INSTALL/usr/lib/systemd/catalog

  # meh presets
  rm -rf $INSTALL/usr/lib/systemd/system-preset

  # remove networkd
  rm -rf $INSTALL/usr/lib/systemd/network

  # tune journald.conf
  sed -e "s,^.*Compress=.*$,Compress=no,g" -i $INSTALL/etc/systemd/journald.conf
  sed -e "s,^.*SplitMode=.*$,SplitMode=none,g" -i $INSTALL/etc/systemd/journald.conf
  sed -e "s,^.*MaxRetentionSec=.*$,MaxRetentionSec=1day,g" -i $INSTALL/etc/systemd/journald.conf
  sed -e "s,^.*RuntimeMaxUse=.*$,RuntimeMaxUse=2M,g" -i $INSTALL/etc/systemd/journald.conf
  sed -e "s,^.*RuntimeMaxFileSize=.*$,RuntimeMaxFileSize=128K,g" -i $INSTALL/etc/systemd/journald.conf
  sed -e "s,^.*SystemMaxUse=.*$,SystemMaxUse=10M,g" -i $INSTALL/etc/systemd/journald.conf

  # tune logind.conf
  sed -e "s,^.*HandleLidSwitch=.*$,HandleLidSwitch=ignore,g" -i $INSTALL/etc/systemd/logind.conf

  # replace systemd-machine-id-setup with ours
  rm -rf $INSTALL/usr/lib/systemd/systemd-machine-id-commit
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-machine-id-commit.service
  rm -rf $INSTALL/usr/lib/systemd/system/*.target.wants/systemd-machine-id-commit.service
  rm -rf $INSTALL/usr/bin/systemd-machine-id-setup
  mkdir -p $INSTALL/usr/bin
  cp $PKG_DIR/scripts/systemd-machine-id-setup $INSTALL/usr/bin

  # provide 'halt', 'shutdown', 'reboot' & co.
  mkdir -p $INSTALL/usr/sbin
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/halt
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/poweroff
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/reboot
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/runlevel
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/shutdown
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/telinit

  mkdir -p $INSTALL/usr/config
  cp -PR $PKG_DIR/config/* $INSTALL/usr/config

  rm -rf $INSTALL/etc/modules-load.d
  ln -sf /storage/.config/modules-load.d $INSTALL/etc/modules-load.d
  rm -rf $INSTALL/etc/sysctl.d
  ln -sf /storage/.config/sysctl.d $INSTALL/etc/sysctl.d
  rm -rf $INSTALL/etc/tmpfiles.d
  ln -sf /storage/.config/tmpfiles.d $INSTALL/etc/tmpfiles.d
  rm -rf $INSTALL/etc/udev/hwdb.d
  ln -sf /storage/.config/hwdb.d $INSTALL/etc/udev/hwdb.d
  rm -rf $INSTALL/etc/udev/rules.d
  ln -sf /storage/.config/udev.rules.d $INSTALL/etc/udev/rules.d
}

post_install() {
  add_group systemd-journal 190

  add_group systemd-network 193
  add_user systemd-network x 193 193 "systemd-network" "/" "/bin/sh"

  add_group audio 63
  add_group cdrom 11
  add_group dialout 18
  add_group disk 6
  add_group floppy 19
  add_group kmem 9
  add_group lp 7
  add_group tape 33
  add_group tty 5
  add_group video 39
  add_group utmp 22
  add_group input 199

  enable_service machine-id.service
  enable_service debugconfig.service
  enable_service userconfig.service
  enable_service hwdb.service
}
