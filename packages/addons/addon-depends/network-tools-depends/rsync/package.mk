################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="rsync"
PKG_VERSION="3.1.2"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.samba.org/ftp/rsync/rsync.html"
PKG_URL="https://download.samba.org/pub/rsync/src/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network/backup"
PKG_SHORTDESC="rsync: A replacement for rcp that has many more features"
PKG_LONGDESC="Rsync uses an own 'rsync' algorithm which provides a very fast method for bringing remote files into sync. It does this by sending just the differences in the files across the link, without requiring that both sets of files are present at one of the ends of the link beforehand. At first glance this may seem impossible because the calculation of diffs between two files normally requires local access to both files."
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-acl-support \
            --disable-xattr-support \
            --with-included-popt"

makeinstall_target() {
  : # nop
}
