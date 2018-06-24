################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="stress-ng"
PKG_VERSION="0.09.31"
PKG_SHA256="a6e4287449b2694c4498a6b3836b911059392d263594ade1f6d224cb68b1c04c"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://kernel.ubuntu.com/~cking/stress-ng/"
PKG_URL="http://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain attr keyutils libaio libcap zlib"
PKG_SECTION="tools"
PKG_LONGDESC="stress-ng will stress test a computer system in various selectable ways"
