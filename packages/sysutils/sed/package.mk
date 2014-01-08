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

PKG_NAME="sed"
PKG_VERSION="4.2.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="ftp://ftp.gnu.org/pub/gnu/sed/"
PKG_URL="http://ftp.gnu.org/gnu/sed/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_BUILD_DEPENDS_HOST="ccache:host"
PKG_PRIORITY="optional"
PKG_SECTION="sysutils"
PKG_SHORTDESC="sed: This is the GNU implementation of the POSIX stream editor"
PKG_LONGDESC="The sed (Stream EDitor) editor is a stream or batch (non-interactive) editor. Sed takes text as input, performs an operation or set of operations on the text and outputs the modified text. The operations that sed performs (substitutions, deletions, insertions, etc.) can be specified in a script file or from the command line."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--disable-nls --disable-acl --without-selinux"
PKG_MAKEINSTALL_OPTS_HOST="-C sed install"
