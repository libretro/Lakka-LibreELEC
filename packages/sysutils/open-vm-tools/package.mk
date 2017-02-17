################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
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

PKG_NAME="open-vm-tools"
PKG_VERSION="stable-10.1.0"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://open-vm-tools.sourceforge.net"
PKG_URL="https://github.com/vmware/open-vm-tools/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib:host glib libdnet fuse"
PKG_SECTION="virtualization"
PKG_SHORTDESC="open-vm-tools: open source implementation of VMware Tools"
PKG_LONGDESC="open-vm-tools: open source implementation of VMware Tools"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--disable-docs \
                           --disable-tests \
                           --disable-deploypkg \
                           --without-pam \
                           --without-gtk2 \
                           --without-gtkmm \
                           --without-ssl \
                           --without-x \
                           --without-xerces \
                           --without-icu \
                           --without-procps \
                           --without-kernel-modules \
                           --with-udev-rules-dir=/usr/lib/udev/rules.d/ \
                           --with-sysroot=$SYSROOT_PREFIX"

post_unpack() {
  mv $PKG_BUILD/$PKG_NAME/* $PKG_BUILD/

  sed -i -e 's|.*common-agent/etc/config/Makefile.*||' $PKG_BUILD/configure.ac
  mkdir -p $PKG_BUILD/common-agent/etc/config
}

pre_configure_target() {
  export LIBS="-ldnet"
}

post_makeinstall_target() {
  rm -rf $INSTALL/sbin
  rm -rf $INSTALL/usr/share
  rm -rf $INSTALL/etc/vmware-tools/scripts/vmware/network

  find $INSTALL/etc/vmware-tools/ -type f | xargs sed -i '/.*expr.*/d'
}

post_install() {
  enable_service vmtoolsd.service
  enable_service vmware-vmblock-fuse.service
}
