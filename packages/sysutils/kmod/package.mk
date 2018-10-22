# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="kmod"
PKG_VERSION="24"
PKG_SHA256="610b8d1df172acc39a4fdf1eaa47a57b04873c82f32152e7a62e29b6ff9cb397"
PKG_LICENSE="GPL"
PKG_SITE="http://git.profusion.mobi/cgit.cgi/kmod.git/"
PKG_URL="https://www.kernel.org/pub/linux/utils/kernel/kmod/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="kmod offers the needed flexibility and fine grained control over insertion, removal, configuration and listing of kernel modules."

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
    ln -sf /usr/bin/kmod $INSTALL/usr/sbin/depmod

  mkdir -p $INSTALL/etc
    ln -sf /storage/.config/modprobe.d $INSTALL/etc/modprobe.d

# add user modprobe.d dir
  mkdir -p $INSTALL/usr/config/modprobe.d
}
