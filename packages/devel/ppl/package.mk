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

PKG_NAME="ppl"
PKG_VERSION="1.1pre10"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.cs.unipr.it/ppl"
PKG_URL="http://bugseng.com/products/ppl/download/ftp/snapshots/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host gmp:host"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="ppl: Parma Polyhedra Library"
PKG_LONGDESC="The Parma Polyhedra Library (PPL) provides numerical abstractions especially targeted at applications in the field of analysis and verification of complex systems."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_HOST="--enable-interfaces=c,cxx --with-gmp=$ROOT/$TOOLCHAIN"

