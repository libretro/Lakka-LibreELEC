PKG_NAME="yasm"
PKG_VERSION="1.3.0"
PKG_LICENSE="BSD"
PKG_SITE="http://www.tortall.net/projects/yasm/"
PKG_URL="http://www.tortall.net/projects/yasm/releases/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_SHORTDESC="yasm: A complete rewrite of the NASM assembler"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_HOST="--disable-debug \
                         --disable-warnerror \
                         --disable-profiling \
                         --disable-gcov \
                         --disable-python \
                         --disable-python-bindings \
                         --enable-nls \
                         --disable-rpath \
                         --without-dmalloc \
                         --with-gnu-ld \
                         --without-libiconv-prefix \
                         --without-libintl-prefix"
