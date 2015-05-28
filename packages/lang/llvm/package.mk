################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="llvm"
PKG_VERSION="3.6.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://llvm.org/"
PKG_URL="http://llvm.org/releases/$PKG_VERSION/${PKG_NAME}-${PKG_VERSION}.src.tar.xz"
PKG_SOURCE_DIR="${PKG_NAME}-${PKG_VERSION}.src"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain llvm:host"
PKG_PRIORITY="optional"
PKG_SECTION="lang"
PKG_SHORTDESC="llvm: Low Level Virtual Machine"
PKG_LONGDESC="Low-Level Virtual Machine (LLVM) is a compiler infrastructure designed for compile-time, link-time, run-time, and idle-time optimization of programs from arbitrary programming languages. It currently supports compilation of C, Objective-C, and C++ programs, using front-ends derived from GCC 4.0, GCC 4.2, and a custom new front-end, "clang". It supports x86, x86-64, ia64, PowerPC, and SPARC, with support for Alpha and ARM under development."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# package specific configure options
PKG_CONFIGURE_OPTS_HOST="--disable-polly \
                         --disable-libcpp \
                         --disable-cxx11 \
                         --disable-split-dwarf \
                         --disable-clang-arcmt \
                         --disable-clang-static-analyzer \
                         --disable-clang-rewriter \
                         --disable-zlib \
                         --disable-assertions \
                         --disable-werror \
                         --disable-terminfo \
                         --enable-optimized \
                         --disable-debug-runtime \
                         --disable-debug-symbols \
                         --enable-keep-symbols \
                         --enable-targets=r600"

PKG_CONFIGURE_OPTS_TARGET="--enable-polly \
                           --disable-libcpp \
                           --disable-cxx11 \
                           --disable-split-dwarf \
                           --disable-clang-arcmt \
                           --disable-clang-static-analyzer \
                           --disable-clang-rewriter \
                           --enable-optimized \
                           --disable-profiling \
                           --disable-assertions \
                           --disable-werror \
                           --disable-terminfo \
                           --disable-expensive-checks \
                           --disable-debug-runtime \
                           --disable-debug-symbols \
                           --enable-keep-symbols \
                           --enable-jit \
                           --disable-docs \
                           --disable-doxygen \
                           --enable-threads \
                           --enable-pthreads \
                           --enable-zlib \
                           --enable-pic \
                           --enable-shared \
                           --enable-embed-stdcxx \
                           --enable-timestamps \
                           --disable-backtraces \
                           --disable-libffi \
                           --disable-ltdl-install"

if [ "$TARGET_ARCH" = x86_64 ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-targets=x86_64,r600"
elif [ "$TARGET_ARCH" = arm ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-targets=arm"
fi

PKG_MAKE_OPTS_HOST="BUILD_DIRS_ONLY=1 CFLAGS= CXXFLAGS="

pre_configure_host() {
  ( cd ../autoconf
    aclocal  --force --verbose -I m4
    autoconf --force --verbose -I m4 -o ../configure
  )

  # we are building hosttools inside the target builddir
    mkdir -p ../.$TARGET_NAME && cd ../.$TARGET_NAME/
    rm -rf ../.$HOST_NAME
    mkdir -p BuildTools && cd BuildTools
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CXXFLAGS="$CXXFLAGS -fPIC"
}

makeinstall_host() {
# nothing to install here
 :
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/BugpointPasses.so
  rm -rf $INSTALL/usr/lib/LLVMHello.so
  rm -rf $INSTALL/usr/lib/libLTO.so
  rm -rf $INSTALL/usr/lib/libprofile_rt.so
}
