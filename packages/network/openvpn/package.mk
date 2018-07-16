# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="openvpn"
PKG_VERSION="2.4.1"
PKG_SHA256="fde9e22c6df7a335d2d58c6a4d5967be76df173c766a5c51ece57fd044c76ee5"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://openvpn.net"
PKG_URL="http://swupdate.openvpn.org/community/releases/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain lzo openssl"
PKG_SECTION="network"
PKG_SHORTDESC="openvpn: a full featured SSL VPN software solution that integrates OpenVPN server capabilities."
PKG_LONGDESC="OpenVPN Access Server is a full featured SSL VPN software solution that integrates OpenVPN server capabilities, enterprise management capabilities, simplified OpenVPN Connect UI, and OpenVPN Client software packages that accommodate Windows, MAC, and Linux OS environments. OpenVPN Access Server supports a wide range of configurations, including secure and granular remote access to internal network and/ or private cloud network resources and applications with fine-grained access control."

PKG_CONFIGURE_OPTS_TARGET="ac_cv_have_decl_TUNSETPERSIST=no \
                           --disable-server \
                           --disable-plugins \
                           --enable-iproute2 IPROUTE=/sbin/ip \
                           --enable-management \
                           --enable-fragment \
                           --disable-multihome \
                           --disable-port-share \
                           --disable-debug"

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    ln -sf ../sbin/openvpn $INSTALL/usr/bin/openvpn
}
