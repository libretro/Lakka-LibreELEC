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
PKG_VERSION="9.4.0-1280544"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://open-vm-tools.sourceforge.net"
PKG_URL="$SOURCEFORGE_SRC/project/open-vm-tools/open-vm-tools/stable-9.4.x/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glib"
PKG_PRIORITY="optional"
PKG_SECTION="virtualization"
PKG_SHORTDESC="open-vm-tools: open source implementation of VMware Tools"
PKG_LONGDESC="open-vm-tools: open source implementation of VMware Tools"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

OPENVMTOOLS_KERNEL_VER=$(basename $(ls -d $ROOT/$BUILD/linux-[0-9]*)| sed 's|linux-||g')

PKG_CONFIGURE_OPTS_TARGET="--disable-docs \
                           --disable-tests \
                           --without-pam \
                           --without-gtk2 \
                           --without-gtkmm \
                           --without-dnet \
                           --without-x \
                           --without-icu \
                           --without-procps \
                           --without-kernel-modules"

PKG_MAKE_OPTS_TARGET="CFLAGS+=-DG_DISABLE_DEPRECATED"

makeinstall_target() {

  mkdir -p $INSTALL/usr/lib
    cp -PR libvmtools/.libs/libvmtools.so* $INSTALL/usr/lib

  mkdir -p $INSTALL/usr/bin
    cp -PR services/vmtoolsd/.libs/vmtoolsd $INSTALL/usr/bin
    cp -PR checkvm/.libs/vmware-checkvm $INSTALL/usr/bin
}

post_install() {
  enable_service open-vm-tools.service
}
