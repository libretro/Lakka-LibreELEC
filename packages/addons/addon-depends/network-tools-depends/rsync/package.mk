################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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
PKG_VERSION="3.1.3"
PKG_SHA256="55cc554efec5fdaad70de921cd5a5eeb6c29a95524c715f3bbf849235b0800c0"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="http://www.samba.org/ftp/rsync/rsync.html"
PKG_URL="https://download.samba.org/pub/rsync/src/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network/backup"
PKG_SHORTDESC="rsync: A replacement for rcp that has many more features"
PKG_LONGDESC="Rsync uses an own 'rsync' algorithm which provides a very fast method for bringing remote files into sync."

PKG_CONFIGURE_OPTS_TARGET="--disable-acl-support \
                           --disable-xattr-support \
                           --with-included-popt"

makeinstall_target() {
  :
}
