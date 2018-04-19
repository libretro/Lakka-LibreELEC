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

PKG_NAME="sshfs"
PKG_VERSION="2.10"
PKG_SHA256="70845dde2d70606aa207db5edfe878e266f9c193f1956dd10ba1b7e9a3c8d101"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libfuse/sshfs"
PKG_URL="https://github.com/libfuse/sshfs/releases/download/sshfs-$PKG_VERSION/sshfs-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse glib"
PKG_SECTION="tools"
PKG_SHORTDESC="sshfs: a filesystem client based on the SSH File Transfer Protocol"
PKG_LONGDESC="This is a filesystem client based on the SSH File Transfer Protocol."

makeinstall_target() {
  :
}
