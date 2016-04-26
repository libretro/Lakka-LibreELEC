################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
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

PKG_NAME="qt"
PKG_VERSION="4.8.7"
PKG_LICENSE="OSS"
PKG_SITE="http://qt-project.org"
PKG_URL="http://download.qt-project.org/official_releases/qt/4.8/${PKG_VERSION}/qt-everywhere-opensource-src-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="qt-everywhere-opensource-src-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain Python zlib:host zlib"
PKG_SHORTDESC="Qt GUI toolkit"
PKG_LONGDESC="Qt GUI toolkit"

QMAKE_CONF_DIR="mkspecs/qws/linux-openelec-g++"
QMAKE_CONF="${QMAKE_CONF_DIR}/qmake.conf"


PKG_CONFIGURE_OPTS_TARGET="-prefix /usr \
                           -hostprefix $SYSROOT_PREFIX \
                           -xplatform qws/linux-openelec-g++ \
                           -make libs \
                           -force-pkg-config \
                           -release \
                           -opensource -confirm-license \
                           -static \
                           -fast \
                           -no-accessibility \
                           -no-sql-mysql -no-sql-sqlite \
                           -no-qt3support \
                           -no-xmlpatterns \
                           -no-multimedia \
                           -no-audio-backend \
                           -no-phonon -no-phonon-backend \
                           -no-svg \
                           -no-webkit \
                           -no-javascript-jit \
                           -no-script \
                           -no-scripttools \
                           -no-declarative -no-declarative-debug \
                           -no-neon \
                           -system-zlib \
                           -no-gif \
                           -no-libtiff \
                           -no-libpng \
                           -no-libmng \
                           -no-libjpeg \
                           -no-openssl \
                           -no-rpath \
                           -silent \
                           -optimized-qmake \
                           -no-nis \
                           -no-cups \
                           -no-pch \
                           -no-dbus \
                           -reduce-relocations \
                           -reduce-exports \
                           -no-separate-debug-info \
                           -no-fontconfig \
                           -no-glib \
                           -embedded $TARGET_ARCH"

configure_target() {
  cd ..
  mkdir -p $QMAKE_CONF_DIR
  echo "include(../../common/linux.conf)" > $QMAKE_CONF
  echo "include(../../common/gcc-base-unix.conf)" >> $QMAKE_CONF
  echo "include(../../common/g++-unix.conf)" >> $QMAKE_CONF
  echo "include(../../common/qws.conf)" >> $QMAKE_CONF
  echo "QMAKE_CC = $CC" >> $QMAKE_CONF
  echo "QMAKE_CXX = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK = $CXX" >> $QMAKE_CONF
  echo "QMAKE_LINK_SHLIB = $CXX" >> $QMAKE_CONF
  echo "QMAKE_AR = $AR cqs" >> $QMAKE_CONF
  echo "QMAKE_OBJCOPY = $OBJCOPY" >> $QMAKE_CONF
  echo "QMAKE_STRIP = $STRIP" >> $QMAKE_CONF
  echo "QMAKE_CFLAGS = $CFLAGS" >> $QMAKE_CONF
  echo "QMAKE_CXXFLAGS = $CXXFLAGS" >> $QMAKE_CONF
  echo "QMAKE_LFLAGS = $LDFLAGS" >> $QMAKE_CONF
  echo "load(qt_config)" >> $QMAKE_CONF
  echo '#include "../../linux-g++/qplatformdefs.h"' >> $QMAKE_CONF_DIR/qplatformdefs.h

  CC="" CXX="" LD="" RANLIB="" AR="" AS="" CPPFLAGS="" CFLAGS="" LDFLAGS="" CXXFLAGS="" \
    PKG_CONFIG_SYSROOT_DIR="$SYSROOT_PREFIX" \
    PKG_CONFIG="$ROOT/$TOOLCHAIN/bin/pkg-config" \
    PKG_CONFIG_PATH="$SYSROOT_PREFIX/usr/lib/pkgconfig" \
    ./configure $PKG_CONFIGURE_OPTS_TARGET
}

post_makeinstall_target() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
  cp -P $ROOT/$PKG_BUILD/bin/qmake $ROOT/$TOOLCHAIN/bin
}
