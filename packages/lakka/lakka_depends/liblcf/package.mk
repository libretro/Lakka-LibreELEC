PKG_NAME="liblcf"
PKG_VERSION="34db5415e5a1c40bb89253cf473d4e98cc6e348a"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/EasyRPG/liblcf"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat icu libinih"
PKG_SECTION="devel"
PKG_LONGDESC="Library to handle RPG Maker 2000/2003 and EasyRPG projects"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DCMAKE_BUILD_TYPE=Release"

pre_make_target() {
  find ${PKG_BUILD} -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
  find ${PKG_BUILD} -name build.ninja -exec sed -i "s:isystem :I:g" \{} \;
}
