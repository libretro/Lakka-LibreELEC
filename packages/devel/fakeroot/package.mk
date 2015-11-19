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

# fakeroot-1.20.2 depends on libcap:host, which depends on attr:host
# there are reported buildproblems with attr:host, which should be replicated
# use fakeroot-1.18.4 instead until attr:host builds 

PKG_NAME="fakeroot"
PKG_VERSION="1.20.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="http://fakeroot.alioth.debian.org/"
PKG_URL="http://ftp.debian.org/debian/pool/main/f/fakeroot/${PKG_NAME}_${PKG_VERSION}.orig.tar.bz2"
PKG_DEPENDS_HOST="ccache:host libcap:host"
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="fakeroot: provides a fake root environment by means of LD_PRELOAD and SYSV IPC (or TCP) trickery."
PKG_LONGDESC="fakeroot provides a fake root environment by means of LD_PRELOAD and SYSV IPC (or TCP) trickery."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--with-gnu-ld"
