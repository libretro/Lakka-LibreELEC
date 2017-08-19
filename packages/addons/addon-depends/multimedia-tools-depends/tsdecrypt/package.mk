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

PKG_NAME="tsdecrypt"
PKG_VERSION="10.0"
PKG_SHA256="a337a7d60cc8f78b9dffbd7d675390497763bcb8f878ec9f1bec3eb80f32b1f1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://georgi.unixsol.org/programs/tsdecrypt"
PKG_URL="http://georgi.unixsol.org/programs/tsdecrypt/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libdvbcsa"
PKG_SECTION="tools"
PKG_SHORTDESC="tsdecrypt"
PKG_LONGDESC="tsdecrypt reads incoming mpeg transport stream over UDP/RTP and then decrypts it using libdvbcsa/ffdecsa and keys obtained from OSCAM or similar cam server"
PKG_AUTORECONF="no"

make_target() {
  make CC=$CC LINK="$LD -o"
}

post_make_target() {
  make strip STRIP=$STRIP
}

makeinstall_target() {
  : # nop
}
