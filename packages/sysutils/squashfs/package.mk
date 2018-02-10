################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="squashfs"
PKG_VERSION="e38956b"
PKG_SHA256="d49241e238076ee56920c6aec31f0de7b41fe770d1b2c03d1714bbffb833a98f"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git"
PKG_URL="https://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git/snapshot/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_VERSION"
PKG_DEPENDS_HOST="ccache:host zlib:host lzo:host xz:host zstd:host"
PKG_NEED_UNPACK="$(get_pkg_directory zlib) $(get_pkg_directory lzo) $(get_pkg_directory xz) $(get_pkg_directory zstd)"
PKG_SECTION="sysutils"
PKG_SHORTDESC="squashfs-tools: A compressed read-only filesystem for Linux"
PKG_LONGDESC="Squashfs is intended to be a general read-only filesystem, for archival use (i.e. in cases where a .tar.gz file may be used), and in constrained block device/memory systems (e.g. embedded systems) where low overhead is needed. The filesystem is currently stable and has been tested on PowerPC, i386, SPARC and ARM architectures."
PKG_TOOLCHAIN="manual"

make_host() {
  make -C squashfs-tools mksquashfs \
       XZ_SUPPORT=1 LZO_SUPPORT=1 ZSTD_SUPPORT=1 \
       XATTR_SUPPORT=0 XATTR_DEFAULT=0 \
       INCLUDEDIR="-I. -I$TOOLCHAIN/include"
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp squashfs-tools/mksquashfs $TOOLCHAIN/bin
}
