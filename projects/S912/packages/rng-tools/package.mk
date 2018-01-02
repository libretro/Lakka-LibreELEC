PKG_NAME="rng-tools"
PKG_VERSION="5"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/gkernel/files/rng-tools/"
PKG_URL="$SOURCEFORGE_SRC/gkernel/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="rng-tools: Daemon to use a Hardware TRNG"
PKG_LONGDESC="The rngd daemon acts as a bridge between a Hardware TRNG (true random number generator) such as the ones in some Intel/AMD/VIA chipsets, and the kernel's PRNG (pseudo-random number generator)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

post_install() {
  enable_service rng-tools.service
}
