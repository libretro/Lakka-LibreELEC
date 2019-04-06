
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

PKG_NAME="libdrm"
PKG_VERSION="2.4.75" #actually 2.4.0?
PKG_ARCH="any"
PKG_LICENSE="nonfree"
PKG_SITE="http://dri.freedesktop.org"
PKG_DEPENDS_TARGET="toolchain libpthread-stubs libpciaccess"
PKG_SECTION="graphics"
PKG_SHORTDESC="libdrm: Userspace interface to kernel DRM services"
PKG_LONGDESC="The userspace interface library to kernel DRM services."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
	:
}

# TODO: Includes? Snatch them from the freedesktop tarball

makeinstall_target() {
	mkdir -p $INSTALL/usr/lib
	cp $PKG_DIR/files/*.so* $INSTALL/usr/lib/
	cp $PKG_DIR/files/*.pc $TOOLCHAIN/aarch64-libreelec-linux-gnueabi/sysroot/usr/lib/pkgconfig/
}