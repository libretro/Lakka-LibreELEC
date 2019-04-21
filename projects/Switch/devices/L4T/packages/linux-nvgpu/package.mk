################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="linux-nvgpu"
PKG_VERSION="tegra-l4t-r32.1"
PKG_VERSION_LONG="tegra-l4t-r32.1.1"
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="https://nv-tegra.nvidia.com/gitweb"
PKG_URL="https://nv-tegra.nvidia.com/gitweb/?p=$PKG_NAME.git;a=snapshot;h=$PKG_VERSION;sf=tgz"
PKG_CLEAN="linux"

make_target() {
	:
}

makeinstall_target() {
	:
}

make_host() {
	:
}

makeinstall_host() {
	:
}

make_init() {
	:
}

makeinstall_init() {
	:
}

unpack() {
	mkdir -p $PKG_BUILD
	tar -xf "$SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION_LONG;sf=tgz" -C $PKG_BUILD --strip 1
}