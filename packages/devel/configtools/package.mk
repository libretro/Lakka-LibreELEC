################################################################################
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="configtools"
PKG_VERSION="706fbe5"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://git.savannah.gnu.org/cgit/config.git"
PKG_URL="http://git.savannah.gnu.org/cgit/config.git/snapshot/$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="$PKG_VERSION*"
PKG_DEPENDS_HOST=""
PKG_SHORTDESC="configtools"
PKG_LONGDESC="configtools"

make_host() {
  :
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/configtools
  cp config.* $TOOLCHAIN/configtools
}
