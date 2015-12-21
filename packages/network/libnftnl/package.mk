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

PKG_NAME="libnftnl"
PKG_VERSION="1.0.5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://netfilter.org/projects/libnftnl"
PKG_URL="http://netfilter.org/projects/libnftnl/files/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libmnl"
PKG_PRIORITY="optional"
PKG_SECTION="network"
PKG_SHORTDESC="libnftnl: a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem."
PKG_LONGDESC="libnftnl is a userspace library providing a low-level netlink programming interface (API) to the in-kernel nf_tables subsystem. The library libnftnl has been previously known as libnftables. This library is currently used by nftables."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"

