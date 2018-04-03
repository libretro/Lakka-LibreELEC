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

PKG_NAME="llvm"
PKG_VERSION="6.0.0"
PKG_SHA256="1ff53c915b4e761ef400b803f07261ade637b0c269d99569f18040f3dcee4408"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://llvm.org/"
PKG_URL="http://llvm.org/releases/$PKG_VERSION/${PKG_NAME}-${PKG_VERSION}.src.tar.xz"
PKG_SOURCE_DIR="${PKG_NAME}-${PKG_VERSION}.src"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain llvm:host zlib"
PKG_SECTION="lang"
PKG_SHORTDESC="llvm: Low Level Virtual Machine"
PKG_LONGDESC="Low-Level Virtual Machine (LLVM) is a compiler infrastructure designed for compile-time, link-time, run-time, and idle-time optimization of programs from arbitrary programming languages. It currently supports compilation of C, Objective-C, and C++ programs, using front-ends derived from GCC 4.0, GCC 4.2, and a custom new front-end, "clang". It supports x86, x86-64, ia64, PowerPC, and SPARC, with support for Alpha and ARM under development."

PKG_CMAKE_OPTS_COMMON="-DLLVM_INCLUDE_TOOLS=ON \
                       -DLLVM_BUILD_TOOLS=OFF \
                       -DLLVM_BUILD_UTILS=OFF \
                       -DLLVM_BUILD_EXAMPLES=OFF \
                       -DLLVM_INCLUDE_EXAMPLES=OFF \
                       -DLLVM_BUILD_TESTS=OFF \
                       -DLLVM_INCLUDE_TESTS=OFF \
                       -DLLVM_INCLUDE_GO_TESTS=OFF \
                       -DLLVM_BUILD_DOCS=OFF \
                       -DLLVM_INCLUDE_DOCS=OFF \
                       -DLLVM_ENABLE_DOXYGEN=OFF \
                       -DLLVM_ENABLE_SPHINX=OFF \
                       -DLLVM_TARGETS_TO_BUILD="AMDGPU" \
                       -DLLVM_ENABLE_TERMINFO=OFF \
                       -DLLVM_ENABLE_ASSERTIONS=OFF \
                       -DLLVM_ENABLE_WERROR=OFF \
                       -DLLVM_ENABLE_ZLIB=ON \
                       -DLLVM_BUILD_LLVM_DYLIB=ON \
                       -DLLVM_LINK_LLVM_DYLIB=ON \
                       -DLLVM_OPTIMIZED_TABLEGEN=ON \
                       -DLLVM_APPEND_VC_REV=OFF"

PKG_CMAKE_OPTS_HOST="$PKG_CMAKE_OPTS_COMMON \
                     -DCMAKE_INSTALL_RPATH=$TOOLCHAIN/lib"

make_host() {
  ninja llvm-config llvm-tblgen
}

makeinstall_host() {
  cp -a bin/llvm-config $SYSROOT_PREFIX/usr/bin/llvm-config-host
  cp -a bin/llvm-tblgen $TOOLCHAIN/bin
}

PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_COMMON \
                       -DCMAKE_BUILD_TYPE=MinSizeRel \
                       -DCMAKE_C_FLAGS="$CFLAGS" \
                       -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
                       -DLLVM_TARGET_ARCH="$TARGET_ARCH" \
                       -DLLVM_TABLEGEN=$TOOLCHAIN/bin/llvm-tblgen"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/LLVMHello.so
  rm -rf $INSTALL/usr/lib/libLTO.so
  rm -rf $INSTALL/usr/share
}
