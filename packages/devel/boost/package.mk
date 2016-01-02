################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="boost"
PKG_VERSION="1_60_0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.boost.org/"
PKG_URL="$SOURCEFORGE_SRC/boost/boost/1.56.0/${PKG_NAME}_${PKG_VERSION}.tar.bz2"
PKG_SOURCE_DIR="${PKG_NAME}_${PKG_VERSION}"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain boost:host Python:host zlib bzip2"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="boost: Peer-reviewed STL style libraries for C++"
PKG_LONGDESC="Boost provides free peer-reviewed portable C++ source libraries. The emphasis is on libraries which work well with the C++ Standard Library. One goal is to establish existing practice and provide reference implementations so that the Boost libraries are suitable for eventual standardization. Some of the libraries have already been proposed for inclusion in the C++ Standards Committee's upcoming C++ Standard Library Technical Report."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
  cd tools/build/src/engine
    sh build.sh
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp bin.*/bjam $ROOT/$TOOLCHAIN/bin
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
  export LDFLAGS="$LDFLAGS -fPIC"
}

configure_target() {
  sh bootstrap.sh --prefix=/usr \
                  --with-bjam=$ROOT/$TOOLCHAIN/bin/bjam \
                  --with-python=$ROOT/$TOOLCHAIN/bin/python \

  echo "using gcc : `$TARGET_CC -v 2>&1  | tail -n 1 |awk '{print $3}'` : $TARGET_CC  : <compileflags>\"$CFLAGS\" <linkflags>\"$LDFLAGS\" ;" \
    > tools/build/src/user-config.jam
}

make_target() {
  : # nothing todo, we use makeinstall_target()
}

makeinstall_target() {
  $ROOT/$TOOLCHAIN/bin/bjam -d2 --toolset=gcc link=static \
                                --prefix=$SYSROOT_PREFIX/usr \
                                --ignore-site-config \
                                --layout=system \
                                --with-thread \
                                --with-iostreams \
                                --with-system \
                                --with-serialization \
                                --with-filesystem \
                                --with-regex -sICU_PATH="$SYSROOT_PREFIX/usr" \
                                install
}
