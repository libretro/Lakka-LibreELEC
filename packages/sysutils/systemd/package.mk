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
PKG_VERSION="208"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/systemd"
PKG_URL="http://www.freedesktop.org/software/systemd/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS="dbus kmod util-linux glib libgcrypt"
PKG_BUILD_DEPENDS_TARGET="toolchain attr libcap dbus:bootstrap kmod util-linux glib libgcrypt"
PKG_PRIORITY="required"
PKG_SECTION="system"
PKG_SHORTDESC="systemd: a system and session manager"
PKG_LONGDESC="systemd is a system and session manager for Linux, compatible with SysV and LSB init scripts. systemd provides aggressive parallelization capabilities, uses socket and D-Bus activation for starting services, offers on-demand starting of daemons, keeps track of processes using Linux cgroups, supports snapshotting and restoring of the system state, maintains mount and automount points and implements an elaborate transactional dependency-based service control logic. It can work as a drop-in replacement for sysvinit."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

# libgcrypt is needed actually only for autoreconf
  PKG_DEPENDS="$PKG_DEPENDS libgcrypt"
  PKG_BUILD_DEPENDS="$PKG_BUILD_DEPENDS libgcrypt"

# TODO: use cpp directly to avoid using 'gcc -E' in Makefiles
#  export CPP=${TARGET_PREFIX}cpp

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           KMOD=/usr/bin/kmod \
                           --disable-nls \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-gtk-doc-pdf \
                           --disable-coverage \
                           --enable-kmod \
                           --enable-blkid \
                           --disable-ima \
                           --disable-chkconfig \
                           --disable-selinux \
                           --disable-xz \
                           --disable-tcpwrap \
                           --disable-pam \
                           --disable-acl \
                           --disable-xattr \
                           --disable-smack \
                           --disable-gcrypt \
                           --disable-audit \
                           --disable-libcryptsetup \
                           --disable-qrencode \
                           --disable-microhttpd \
                           --disable-binfmt \
                           --disable-vconsole \
                           --disable-readahead \
                           --disable-bootchart \
                           --disable-quotacheck \
                           --enable-tmpfiles \
                           --disable-randomseed \
                           --enable-logind \
                           --disable-backlight \
                           --disable-machined \
                           --disable-hostnamed \
                           --disable-timedated \
                           --disable-localed \
                           --disable-coredump \
                           --disable-polkit \
                           --disable-efi \
                           --disable-myhostname \
                           --enable-gudev \
                           --disable-manpages \
                           --disable-tests \
                           --without-python \
                           --disable-python-devel \
                           --enable-split-usr \
                           --with-firmware-path=/storage/.config/firmware:/lib/firmware \
                           --with-sysvinit-path= \
                           --with-sysvrcnd-path= \
                           --with-tty-gid=5 \
                           --with-rootprefix= \
                           --with-rootlibdir=/lib"

pre_make_target() {
# dont build parallel
  MAKEFLAGS=-j1
}

post_makeinstall_target() {
  # remove unneeded stuff
    rm -rf $INSTALL/etc/systemd/system
    rm -rf $INSTALL/usr/share/zsh
    rm -rf $INSTALL/usr/lib/kernel/install.d
    rm -rf $INSTALL/usr/lib/rpm
    rm  -f $INSTALL/usr/bin/kernel-install

   rm -f $INSTALL/lib/udev/hwdb.d/20-OUI.hwdb
   rm -f $INSTALL/lib/udev/hwdb.d/20-acpi-vendor.hwdb
   rm -f $INSTALL/lib/udev/hwdb.d/20-bluetooth-vendor-product.hwdb
   rm -f $INSTALL/lib/udev/hwdb.d/20-pci-classes.hwdb
   rm -f $INSTALL/lib/udev/hwdb.d/20-pci-vendor-model.hwdb
   rm -f $INSTALL/lib/udev/hwdb.d/20-usb-classes.hwdb
   rm -f $INSTALL/lib/udev/hwdb.d/20-usb-vendor-model.hwdb

  # tune journald.conf
    sed -e "s,^.*Compress=.*$,Compress=no,g" -i $INSTALL/etc/systemd/journald.conf
    sed -e "s,^.*SplitMode=.*$,SplitMode=none,g" -i $INSTALL/etc/systemd/journald.conf
    sed -e "s,^.*MaxRetentionSec=.*$,MaxRetentionSec=1day,g" -i $INSTALL/etc/systemd/journald.conf
    sed -e "s,^.*RuntimeMaxUse=.*$,RuntimeMaxUse=2M,g" -i $INSTALL/etc/systemd/journald.conf
    sed -e "s,^.*RuntimeMaxFileSize=.*$,RuntimeMaxFileSize=128K,g" -i $INSTALL/etc/systemd/journald.conf
    sed -e "s,^.*SystemMaxUse=.*$,SystemMaxUse=10M,g" -i $INSTALL/etc/systemd/journald.conf

  # replace systemd-machine-id-setup with ours
    mkdir -p $INSTALL/bin
      rm -rf $INSTALL/bin/systemd-machine-id-setup
      cp $PKG_DIR/scripts/systemd-machine-id-setup $INSTALL/bin

  # copy openelec helper scripts
    mkdir -p $INSTALL/usr/lib/openelec
      cp $PKG_DIR/scripts/openelec-userconfig $INSTALL/usr/lib/openelec/

  # provide 'halt', 'shutdown', 'reboot' & co.
    mkdir -p $INSTALL/sbin
      ln -sf /bin/systemctl $INSTALL/sbin/halt
      ln -sf /bin/systemctl $INSTALL/sbin/poweroff
      ln -sf /bin/systemctl $INSTALL/sbin/reboot
      ln -sf /bin/systemctl $INSTALL/sbin/runlevel
      ln -sf /bin/systemctl $INSTALL/sbin/shutdown
      ln -sf /bin/systemctl $INSTALL/sbin/telinit
    mkdir -p $INSTALL/usr/sbin
      ln -sf /bin/systemctl $INSTALL/usr/sbin/halt
      ln -sf /bin/systemctl $INSTALL/usr/sbin/poweroff
      ln -sf /bin/systemctl $INSTALL/usr/sbin/reboot
      ln -sf /bin/systemctl $INSTALL/usr/sbin/runlevel
      ln -sf /bin/systemctl $INSTALL/usr/sbin/shutdown
      ln -sf /bin/systemctl $INSTALL/usr/sbin/telinit
      ln -sf /bin/udevadm $INSTALL/sbin/udevadm

  # remove Network adaper renaming rule, this is confusing
    rm -rf $INSTALL/lib/udev/rules.d/80-net-name-slot.rules

  # remove debug-shell.service, we install our own
    rm -rf $INSTALL/lib/systemd/system/debug-shell.service

  # remove systemd-update-utmp. pointless
    rm -rf $INSTALL/lib/systemd/systemd-update-utmp
    rm -rf $INSTALL/lib/systemd/system/systemd-update-utmp-runlevel.service
    rm -rf $INSTALL/lib/systemd/system/systemd-update-utmp.service
    rm -rf $INSTALL/lib/systemd/system/sysinit.target.wants/systemd-update-utmp.service

  # remove systemd-ask-password. pointless
    rm -rf $INSTALL/lib/systemd/system/systemd-ask-password-wall.service
    rm -rf $INSTALL/lib/systemd/system/systemd-ask-password-wall.path
    rm -rf $INSTALL/lib/systemd/system/systemd-ask-password-console.path
    rm -rf $INSTALL/lib/systemd/system/systemd-ask-password-console.service
    rm -rf $INSTALL/bin/systemd-ask-password
    rm -rf $INSTALL/bin/systemd-tty-ask-password-agent
    rm -rf $INSTALL/lib/systemd/system/sysinit.target.wants/systemd-ask-password-console.path
    rm -rf $INSTALL/lib/systemd/system/multi-user.target.wants/systemd-ask-password-wall.path

  # remove some generators we never use
    rm -rf $INSTALL/lib/systemd/system-generators/systemd-fstab-generator

  # remove getty units, we dont want a console
    rm -rf $INSTALL/lib/systemd/system/autovt@.service
    rm -rf $INSTALL/lib/systemd/system/console-getty.service
    rm -rf $INSTALL/lib/systemd/system/console-shell.service
    rm -rf $INSTALL/lib/systemd/system/getty@.service
    rm -rf $INSTALL/lib/systemd/system/getty.target
    rm -rf $INSTALL/lib/systemd/system/multi-user.target.wants/getty.target

  # remove rootfs fsck
    rm -rf $INSTALL/lib/systemd/system/systemd-fsck-root.service
    rm -rf $INSTALL/lib/systemd/system/local-fs.target.wants/systemd-fsck-root.service

  mkdir -p $INSTALL/usr/config
    cp -PR $PKG_DIR/config/* $INSTALL/usr/config

    rm -rf $INSTALL/etc/modules-load.d
      ln -sf /storage/.config/modules-load.d $INSTALL/etc/modules-load.d
    rm -rf $INSTALL/etc/sysctl.d
      ln -sf /storage/.config/sysctl.d $INSTALL/etc/sysctl.d
    rm -rf $INSTALL/etc/tmpfiles.d
      ln -sf /storage/.config/tmpfiles.d $INSTALL/etc/tmpfiles.d
}

post_install() {
  add_group systemd-journal 190

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

  enable_service machine-id.service
  enable_service debugconfig.service
  enable_service userconfig.service
  enable_service hwdb.service
}
