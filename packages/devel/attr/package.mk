################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2010-2011 Roman Weber (roman@openelec.tv)
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

PKG_NAME="attr"
PKG_VERSION="2.4.47"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="http://download.savannah.gnu.org/releases-noredirect/attr/$PKG_NAME-$PKG_VERSION.src.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="accessibility"
PKG_SHORTDESC="attr: Extended Attributes Of Filesystem Objects"
PKG_LONGDESC="Extended attributes are name:value pairs associated permanently with files and directories, similar to the environment strings associated with a process. An attribute may be defined or undefined. If it is defined, its value may be empty or non-empty. Extended attributes are extensions to the normal attributes which are associated with all inodes in the system (i.e. the stat(2) data). They are often used to provide additional functionality to a filesystem - for example, additional security features such as Access Control Lists (ACLs) may be implemented using extended attributes."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="OPTIMIZER= \
                           CONFIG_SHELL=/bin/bash \
                           INSTALL_USER=root INSTALL_GROUP=root \
                           --disable-shared --enable-static"

if [ "$DEBUG" = yes ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET DEBUG=-DDEBUG"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET DEBUG=-DNDEBUG"
fi

pre_configure_target() {
# attr fails to build in subdirs
  cd $ROOT/$PKG_BUILD
    rm -rf .$TARGET_NAME
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/
    cp libattr/.libs/libattr.a $SYSROOT_PREFIX/usr/lib/

  mkdir -p $SYSROOT_PREFIX/usr/include/attr
    cp include/*.h $SYSROOT_PREFIX/usr/include/attr
}
