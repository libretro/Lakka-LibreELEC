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

PKG_NAME="cmake"
PKG_VERSION="3.5.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://www.cmake.org/"
PKG_URL="http://www.cmake.org/files/v3.5/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="cmake: A cross-platform, open-source make system"
PKG_LONGDESC="CMake is used to control the software compilation process using simple platform and compiler independent configuration files. CMake generates native makefiles and workspaces that can be used in the compiler environment of your choice. CMake is quite sophisticated: it is possible to support complex environments requiring system configuration, preprocessor generation, code generation, and template instantiation."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_host() {
  ../configure --prefix=$ROOT/$TOOLCHAIN \
               --no-qt-gui --no-system-libs \
               -- \
               -DCMAKE_C_FLAGS="-O2 -Wall -pipe -Wno-format-security" \
               -DCMAKE_CXX_FLAGS="-O2 -Wall -pipe -Wno-format-security" \
               -DCMAKE_EXE_LINKER_FLAGS="$HOST_LDFLAGS" \
               -DBUILD_CursesDialog=0
}

post_makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/etc

  cat >$ROOT/$TOOLCHAIN/etc/cmake-$TARGET_NAME.conf <<EOF
# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

# processor (or hardware) of the target system
SET(CMAKE_SYSTEM_PROCESSOR  $TARGET_ARCH)

# specify the cross compiler
SET(CMAKE_C_COMPILER   $TARGET_CC)
SET(CMAKE_CXX_COMPILER $TARGET_CXX)

# where is the target environment 
SET(CMAKE_FIND_ROOT_PATH  $SYSROOT_PREFIX)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

EOF

  cat >$ROOT/$TOOLCHAIN/etc/cmake-$HOST_NAME.conf <<EOF
# this one is important
SET(CMAKE_SYSTEM_NAME Linux)
#this one not so much
SET(CMAKE_SYSTEM_VERSION 1)

# specify the host compiler
SET(CMAKE_C_COMPILER   $HOST_CC)
SET(CMAKE_CXX_COMPILER $HOST_CXX)

# where is the target environment 
SET(CMAKE_FIND_ROOT_PATH  $ROOT/$TOOLCHAIN)

# search for programs in the build host directories
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)

# for libraries and headers in the target directories
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY BOTH)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)

EOF
}
