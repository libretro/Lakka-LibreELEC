# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="iptables"
PKG_VERSION="1.6.1"
PKG_SHA256="0fc2d7bd5d7be11311726466789d4c65fb4c8e096c9182b56ce97440864f0cf5"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.netfilter.org/"
PKG_URL="http://www.netfilter.org/projects/iptables/files/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain linux libmnl libnftnl"
PKG_SECTION="network"
PKG_SHORTDESC="iptables: IP packet filter administration"
PKG_LONGDESC="Iptables is used to set up, maintain, and inspect the tables of IP packet filter rules in the Linux kernel. There are several different tables which may be defined, and each table contains a number of built-in chains, and may contain user-defined chains."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-kernel=$(kernel_path)"


post_makeinstall_target() {
  mkdir -p $INSTALL/usr/config/iptables/
    cp -PR $PKG_DIR/config/README $INSTALL/usr/config/iptables/

  mkdir -p $INSTALL/etc/iptables/
    cp -PR $PKG_DIR/config/* $INSTALL/etc/iptables/

  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/iptables_helper $INSTALL/usr/lib/libreelec
}

post_install() {
  enable_service iptables.service
}

