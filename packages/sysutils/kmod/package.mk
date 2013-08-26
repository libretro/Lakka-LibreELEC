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

PKG_NAME="kmod"
PKG_VERSION="15"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://git.profusion.mobi/cgit.cgi/kmod.git/"
PKG_URL="http://ftp.kernel.org/pub/linux/utils/kernel/kmod/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="system"
PKG_SHORTDESC="kmod offers the needed flexibility and fine grained control over insertion, removal, configuration and listing of kernel modules."
PKG_LONGDESC="kmod offers the needed flexibility and fine grained control over insertion, removal, configuration and listing of kernel modules."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-tools \
                           --enable-logging \
                           --disable-debug \
                           --disable-gtk-doc \
                           --disable-gtk-doc-html \
                           --disable-gtk-doc-pdf \
                           --disable-manpages \
                           --with-gnu-ld \
                           --without-xz \
                           --without-zlib"

post_makeinstall_target() {
# make symlinks for compatibility
  mkdir -p $INSTALL/sbin
    ln -sf /usr/bin/kmod $INSTALL/sbin/lsmod
    ln -sf /usr/bin/kmod $INSTALL/sbin/insmod
    ln -sf /usr/bin/kmod $INSTALL/sbin/rmmod
    ln -sf /usr/bin/kmod $INSTALL/sbin/modinfo
    ln -sf /usr/bin/kmod $INSTALL/sbin/modprobe

# add system modprobe.d dir
  mkdir -p $INSTALL/etc/modprobe.d
    cp $PKG_DIR/modprobe.d/* $INSTALL/etc/modprobe.d

# add user modprobe.d dir
  mkdir -p $INSTALL/usr/config/modprobe.d
}
