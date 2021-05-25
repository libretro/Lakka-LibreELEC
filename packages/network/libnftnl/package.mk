# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libnftnl"
PKG_VERSION="1.2.1"
PKG_SHA256="7508a5c414fab13e3cb3ce8262d0ce4f02c1590a8e4f8628ab497b5b4585937c"
PKG_LICENSE="GPL"
PKG_SITE="http://netfilter.org/projects/libnftnl"
PKG_URL="http://netfilter.org/projects/libnftnl/files/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libmnl"
PKG_LONGDESC="A userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"
