PKG_NAME="webgrabplus"
PKG_VERSION="56.29pre-20160807-mdb"
PKG_REV="103"
PKG_ARCH="any"
PKG_LICENSE="prop."
PKG_SITE="http://www.webgrabplus.com/"
PKG_URL="https://github.com/awiouy/webgrabplus/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="service"
PKG_SHORTDESC="WebGrab+Plus: a multi-site incremental xmltv epg grabber"
PKG_LONGDESC="WebGrab+Plus ($PKG_VERSION) collects tv-program guide data from selected tvguide sites for your favourite channels."
PKG_AUTORECONF="no"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="WebGrab+Plus"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_REPOVERSION="8.0"
PKG_ADDON_REQUIRES="tools.mono:0.0.0"
PKG_MAINTAINER="Anton Voyl (awiouy)"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID
  cp -PR $PKG_BUILD/* $ADDON_BUILD/$PKG_ADDON_ID
}
