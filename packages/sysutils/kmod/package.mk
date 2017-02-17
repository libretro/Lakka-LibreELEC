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

PKG_NAME="kmod"
PKG_VERSION="23"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://git.profusion.mobi/cgit.cgi/kmod.git/"
PKG_URL="http://ftp.kernel.org/pub/linux/utils/kernel/kmod/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="kmod offers the needed flexibility and fine grained control over insertion, removal, configuration and listing of kernel modules."
PKG_LONGDESC="kmod offers the needed flexibility and fine grained control over insertion, removal, configuration and listing of kernel modules."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--enable-tools \
                         --disable-logging \
                         --disable-debug \
                         --disable-gtk-doc \
                         --disable-gtk-doc-html \
                         --disable-gtk-doc-pdf \
                         --disable-manpages \
                         --with-gnu-ld \
                         --without-xz \
                         --without-zlib"

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

post_makeinstall_host() {
  ln -sf kmod $TOOLCHAIN/bin/depmod
}

post_makeinstall_target() {
# make symlinks for compatibility
  mkdir -p $INSTALL/usr/sbin
    ln -sf /usr/bin/kmod $INSTALL/usr/sbin/lsmod
    ln -sf /usr/bin/kmod $INSTALL/usr/sbin/insmod
    ln -sf /usr/bin/kmod $INSTALL/usr/sbin/rmmod
    ln -sf /usr/bin/kmod $INSTALL/usr/sbin/modinfo
    ln -sf /usr/bin/kmod $INSTALL/usr/sbin/modprobe

  mkdir -p $INSTALL/etc
    ln -sf /storage/.config/modprobe.d $INSTALL/etc/modprobe.d

# add user modprobe.d dir
  mkdir -p $INSTALL/usr/config/modprobe.d
}
