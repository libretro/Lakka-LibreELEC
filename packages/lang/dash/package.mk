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

PKG_NAME="dash"
PKG_VERSION="0.5.10.2"
PKG_SHA256="c34e1259c4179a6551dc3ceb41c668cf3be0135c5ec430deb2edfc17fff44da9"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://gondor.apana.org.au/~herbert/dash/"
PKG_URL="https://git.kernel.org/pub/scm/utils/dash/dash.git/snapshot/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST=""
PKG_SECTION="lang"
PKG_SHORTDESC="dash: Debian Almquist shell"
PKG_LONGDESC="DASH is a POSIX-compliant implementation of /bin/sh that aims to be as small as possible. It does this without sacrificing speed where possible. In fact, it is significantly faster than bash (the GNU Bourne-Again SHell) for most tasks."
PKG_TOOLCHAIN="configure"

pre_configure_host() {
  $PKG_BUILD/autogen.sh
}
