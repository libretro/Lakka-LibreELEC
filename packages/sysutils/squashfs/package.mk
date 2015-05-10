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

PKG_NAME="squashfs"
PKG_VERSION="4.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://squashfs.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/squashfs/squashfs/${PKG_NAME}${PKG_VERSION}/${PKG_NAME}${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="${PKG_NAME}${PKG_VERSION}"
PKG_DEPENDS_HOST="ccache:host zlib:host lzo:host xz:host"
PKG_PRIORITY="optional"
PKG_SECTION="sysutils"
PKG_SHORTDESC="squashfs-tools: A compressed read-only filesystem for Linux"
PKG_LONGDESC="Squashfs is intended to be a general read-only filesystem, for archival use (i.e. in cases where a .tar.gz file may be used), and in constrained block device/memory systems (e.g. embedded systems) where low overhead is needed. The filesystem is currently stable and has been tested on PowerPC, i386, SPARC and ARM architectures."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
  make -C squashfs-tools mksquashfs \
       XZ_SUPPORT=1 LZO_SUPPORT=1 \
       INCLUDEDIR="-I. -I$ROOT/$TOOLCHAIN/include"
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp squashfs-tools/mksquashfs $ROOT/$TOOLCHAIN/bin
}
