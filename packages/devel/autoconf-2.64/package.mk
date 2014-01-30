################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="autoconf-2.64"
PKG_VERSION="legacy"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://sources.redhat.com/autoconf/"
PKG_URL="http://ftp.gnu.org/gnu/autoconf/$PKG_NAME.tar.bz2"
PKG_SOURCE_DIR="$PKG_NAME"
PKG_DEPENDS_HOST="ccache:host m4:host"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="autoconf: A GNU tool for automatically configuring source code"
PKG_LONGDESC="Autoconf is an extensible package of m4 macros that produce shell scripts to automatically configure software source code packages. These scripts can adapt the packages to many kinds of UNIX-like systems without manual user intervention. Autoconf creates a configuration script for a package from a template file that lists the operating system features that the package can use, in the form of m4 macro calls."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="EMACS=no \
                         ac_cv_path_M4=$ROOT/$TOOLCHAIN/bin/m4 \
                         ac_cv_prog_gnu_m4_gnu=no \
                         --target=$TARGET_NAME \
                         --program-suffix=-2.64"

make_host() {
 : # nothing todo
}

makeinstall_host() {
  make install \
       prefix=$ROOT/$TOOLCHAIN \
       pkgdatadir=$ROOT/$TOOLCHAIN/share/$PKG_NAME \
       pkgdatadir=$ROOT/$TOOLCHAIN/lib/$PKG_NAME \
       pkgdatadir=$ROOT/$TOOLCHAIN/include/$PKG_NAME \
       install

  make clean
  make install \
       prefix=$SYSROOT_PREFIX/usr \
       pkgdatadir=$SYSROOT_PREFIX/usr/share/$PKG_NAME \
       pkgdatadir=$SYSROOT_PREFIX/usr/lib/$PKG_NAME \
       pkgdatadir=$SYSROOT_PREFIX/usr/include/$PKG_NAME \
       install
}
