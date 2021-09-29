PKG_NAME="opusfile"
PKG_VERSION="58b229a"
PKG_SHA256="fc0088869a3ecb79b1230f536f53ac3a22ddb8378b738038d00eb8acf362da73"
PKG_LICENSE="BSD-3c"
PKG_SITE="https://github.com/xiph/opusfile"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl opus"
PKG_LONGDESC="Stand-alone decoder library for .opus streams"
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic"

pre_configure_target() {
  cd ${PKG_BUILD}
  if [ -f autogen.sh ]; then
    ./autogen.sh
  else
    make distclean
    ./autogen.sh
  fi
}
