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

PKG_NAME="systemd"
PKG_VERSION="237"
PKG_SHA256="c83dabbe1c9de6b9db1dafdb7e04140c7d0535705c68842f6c0768653ba4913c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.freedesktop.org/wiki/Software/systemd"
PKG_URL="https://github.com/systemd/systemd/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libcap kmod util-linux entropy"
PKG_SECTION="system"
PKG_SHORTDESC="systemd: a system and session manager"
PKG_LONGDESC="systemd is a system and session manager for Linux, compatible with SysV and LSB init scripts. systemd provides aggressive parallelization capabilities, uses socket and D-Bus activation for starting services, offers on-demand starting of daemons, keeps track of processes using Linux cgroups, supports snapshotting and restoring of the system state, maintains mount and automount points and implements an elaborate transactional dependency-based service control logic. It can work as a drop-in replacement for sysvinit."

PKG_MESON_OPTS_TARGET="--libdir=/usr/lib \
                       -Drootprefix=/usr \
                       -Dsplit-usr=false \
                       -Ddefault-hierarchy=hybrid \
                       -Dtty-gid=5 \
                       -Dtests=false \
                       -Dseccomp=false \
                       -Dselinux=false \
                       -Dapparmor=false \
                       -Dpolkit=false \
                       -Dacl=false \
                       -Daudit=false \
                       -Dblkid=true \
                       -Dkmod=true \
                       -Dpam=false \
                       -Dmicrohttpd=false \
                       -Dlibcryptsetup=false \
                       -Dlibcurl=false \
                       -Dlibidn=false \
                       -Dlibidn2=false \
                       -Dlibiptc=false \
                       -Dqrencode=false \
                       -Dgcrypt=false \
                       -Dgnutls=false \
                       -Delfutils=false \
                       -Dzlib=false \
                       -Dbzip2=false \
                       -Dxz=false \
                       -Dlz4=false \
                       -Dxkbcommon=false \
                       -Dglib=false \
                       -Ddbus=false \
                       -Ddefault-dnssec=no \
                       -Dimportd=false \
                       -Dremote=false \
                       -Dutmp=false \
                       -Dhibernate=false \
                       -Denvironment-d=false \
                       -Dbinfmt=false \
                       -Dcoredump=false \
                       -Dresolve=false \
                       -Dlogind=true \
                       -Dhostnamed=true \
                       -Dlocaled=false \
                       -Dmachined=false \
                       -Dnetworkd=false \
                       -Dtimedated=false \
                       -Dtimesyncd=false \
                       -Dmyhostname=false \
                       -Dfirstboot=false \
                       -Drandomseed=false \
                       -Dbacklight=false \
                       -Dvconsole=false \
                       -Dquotacheck=false \
                       -Dsysusers=false \
                       -Dtmpfiles=true \
                       -Dhwdb=true \
                       -Drfkill=false \
                       -Dldconfig=false \
                       -Defi=false \
                       -Dtpm=false \
                       -Dima=false \
                       -Dsmack=false \
                       -Dgshadow=false \
                       -Didn=false \
                       -Dnss-systemd=false \
                       -Dman=false \
                       -Dhtml=false \
                       -Dbashcompletiondir=no \
                       -Dzshcompletiondir=no \
                       -Dkill-path=/usr/bin/kill \
                       -Dkmod-path=/usr/bin/kmod \
                       -Dmount-path=/usr/bin/mount \
                       -Dumount-path=/usr/bin/umount"

pre_configure_target() {
  export CFLAGS="$CFLAGS -fno-schedule-insns -fno-schedule-insns2"
  export LC_ALL=en_US.UTF-8
}

post_makeinstall_target() {
  # remove unneeded stuff
  rm -rf $INSTALL/etc/init.d
  rm -rf $INSTALL/etc/pam.d
  rm -rf $INSTALL/etc/systemd/system
  rm -rf $INSTALL/etc/xdg
  rm -rf $INSTALL/etc/X11
  rm  -f $INSTALL/usr/bin/kernel-install
  rm -rf $INSTALL/usr/lib/kernel/install.d
  rm -rf $INSTALL/usr/lib/rpm
  rm -rf $INSTALL/usr/lib/systemd/user
  rm -rf $INSTALL/usr/lib/tmpfiles.d/etc.conf
  rm -rf $INSTALL/usr/lib/tmpfiles.d/home.conf
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

  # remove the uaccess rules as we don't build systemd with ACL (see https://github.com/systemd/systemd/issues/4107)
  rm -rf $INSTALL/usr/lib/udev/rules.d/70-uaccess.rules
  rm -rf $INSTALL/usr/lib/udev/rules.d/71-seat.rules
  rm -rf $INSTALL/usr/lib/udev/rules.d/73-seat-late.rules

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

  # remove systemd-user-sessions
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-user-sessions.service
  rm -rf $INSTALL/usr/lib/systemd/system/*.target.wants/systemd-user-sessions.service

  # remove nspawn
  rm -rf $INSTALL/usr/bin/systemd-nspawn
  rm -rf $INSTALL/usr/lib/systemd/system/systemd-nspawn@.service

  # remove genetators/catalog
  rm -rf $INSTALL/usr/lib/systemd/system-generators
  rm -rf $INSTALL/usr/lib/systemd/catalog

  # remove partition
  rm -rf $INSTALL/usr/lib/systemd/systemd-growfs
  rm -rf $INSTALL/usr/lib/systemd/systemd-makefs

  # distro preset policy
  rm -f $INSTALL/usr/lib/systemd/system-preset/*
  echo "disable *" > $INSTALL/usr/lib/systemd/system-preset/99-default.preset

  rm -f $INSTALL/usr/lib/systemd/user-preset/*
  echo "disable *" > $INSTALL/usr/lib/systemd/user-preset/90-systemd.preset

  # remove networkd
  rm -rf $INSTALL/usr/lib/systemd/network

  # tune journald.conf
  sed -e "s,^.*Compress=.*$,Compress=no,g" -i $INSTALL/etc/systemd/journald.conf
  sed -e "s,^.*SplitMode=.*$,SplitMode=none,g" -i $INSTALL/etc/systemd/journald.conf
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
  cp $PKG_DIR/scripts/userconfig-setup $INSTALL/usr/bin
  cp $PKG_DIR/scripts/usercache-setup $INSTALL/usr/bin

  mkdir -p $INSTALL/usr/sbin
  cp $PKG_DIR/scripts/kernel-overlays-setup $INSTALL/usr/sbin

  # provide 'halt', 'shutdown', 'reboot' & co.
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/halt
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/poweroff
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/reboot
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/runlevel
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/shutdown
  ln -sf /usr/bin/systemctl $INSTALL/usr/sbin/telinit

  # strip
  debug_strip $INSTALL/usr

  # defaults
  mkdir -p $INSTALL/usr/config
  cp -PR $PKG_DIR/config/* $INSTALL/usr/config

  rm -rf $INSTALL/etc/modules-load.d
  ln -sf /storage/.config/modules-load.d $INSTALL/etc/modules-load.d
  rm -rf $INSTALL/etc/systemd/sleep.conf.d
  ln -sf /storage/.config/sleep.conf.d $INSTALL/etc/systemd/sleep.conf.d
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
  enable_service usercache.service
  enable_service kernel-overlays.service
  enable_service hwdb.service
}
