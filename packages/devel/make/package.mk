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

PKG_NAME="make"
PKG_VERSION="4.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://www.gnu.org/software/make/"
PKG_URL="https://ftp.gnu.org/gnu/make/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST=""
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="make: GNU make utility to maintain groups of programs"
PKG_LONGDESC="The 'make' utility automatically determines which pieces of a large program need to be recompiled, and issues commands to recompile them. This is GNU 'make', which was implemented by Richard Stallman and Roland McGrath. GNU 'make' conforms to section 6.2 of EEE Standard 1003.2-1992' (POSIX.2)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

export CC=$LOCAL_CC

post_makeinstall_host() {
  ln -sf make $ROOT/$TOOLCHAIN/bin/gmake
}
