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

PKG_NAME="fuse"
PKG_VERSION="2.9.7"
PKG_SHA256="832432d1ad4f833c20e13b57cf40ce5277a9d33e483205fc63c78111b3358874"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libfuse/libfuse/"
PKG_URL="https://github.com/libfuse/libfuse/releases/download/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="fuse: A simple user-space filesystem interface for Linux"
PKG_LONGDESC="FUSE provides a simple interface for userspace programs to export a virtual filesystem to the Linux kernel. FUSE also aims to provide a secure method for non privileged users to create and mount their own filesystem implementations."
# fuse fails to build with GOLD linker on gcc-4.9
PKG_BUILD_FLAGS="-gold"

PKG_CONFIGURE_OPTS_TARGET="MOUNT_FUSE_PATH=/usr/sbin \
                           --enable-lib \
                           --enable-util \
                           --disable-example \
                           --enable-mtab \
                           --disable-rpath \
                           --with-gnu-ld"

post_makeinstall_target() {
  rm -rf $INSTALL/etc/init.d
  rm -rf $INSTALL/etc/udev
}
