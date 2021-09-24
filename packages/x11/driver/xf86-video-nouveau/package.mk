
PKG_NAME="xf86-video-nouveau"
PKG_VERSION="1.0.16"
PKG_ARCH="any"
PKG_SECTION="x11/driver"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_DEPENDS_TARGET="toolchain util-macros xorg-server"
PKG_URL="http://xorg.freedesktop.org/archive/individual/driver/$PKG_NAME-$PKG_VERSION.tar.bz2"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"
PKG_CONFIGURE_OPTS_TARGET="--enable-glamor --enable-udev --with-xorg-module-dir=$XORG_PATH_MODULES"
