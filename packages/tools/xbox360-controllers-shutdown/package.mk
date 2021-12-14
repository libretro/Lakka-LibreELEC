# SPDX-License-Identifier: GPL-2.0-or-later OR MIT
# 2021 Giovanni Cascione

PKG_NAME="xbox360-controllers-shutdown"
PKG_VERSION="6ce0277"
PKG_SHA256=""
PKG_REV=""
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/spleen1981/xbox360-controllers-shutdown"
PKG_URL="$PKG_SITE".git
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="Small utility to turn off Xbox360 controllers in Linux "
PKG_LONGDESC="Small utility to turn off Xbox360 controllers in Linux "
PKG_TOOLCHAIN="auto"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin/
  cp xbox360-controllers-shutdown $INSTALL/usr/bin/
}

post_install() {
  enable_service xbox360-controllers-shutdown.service
}
