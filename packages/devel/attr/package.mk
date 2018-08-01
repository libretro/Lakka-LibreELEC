# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2010-2011 Roman Weber (roman@openelec.tv)
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="attr"
PKG_VERSION="2.4.47"
PKG_SHA256="25772f653ac5b2e3ceeb89df50e4688891e21f723c460636548971652af0a859"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="http://download.savannah.gnu.org/releases-noredirect/attr/$PKG_NAME-$PKG_VERSION.src.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="accessibility"
PKG_SHORTDESC="attr: Extended Attributes Of Filesystem Objects"
PKG_LONGDESC="Extended attributes are name:value pairs associated permanently with files and directories, similar to the environment strings associated with a process. An attribute may be defined or undefined. If it is defined, its value may be empty or non-empty. Extended attributes are extensions to the normal attributes which are associated with all inodes in the system (i.e. the stat(2) data). They are often used to provide additional functionality to a filesystem - for example, additional security features such as Access Control Lists (ACLs) may be implemented using extended attributes."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="OPTIMIZER= \
                           CONFIG_SHELL=/bin/bash \
                           INSTALL_USER=root INSTALL_GROUP=root \
                           --disable-shared --enable-static"

if build_with_debug; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET DEBUG=-DDEBUG"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET DEBUG=-DNDEBUG"
fi

pre_configure_target() {
# attr fails to build in subdirs
  cd $PKG_BUILD
    rm -rf .$TARGET_NAME
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/
    cp libattr/.libs/libattr.a $SYSROOT_PREFIX/usr/lib/

  mkdir -p $SYSROOT_PREFIX/usr/include/attr
    cp include/*.h $SYSROOT_PREFIX/usr/include/attr
}
