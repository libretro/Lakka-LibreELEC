# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="llvm"
PKG_VERSION="8.0.0"
PKG_SHA256="8872be1b12c61450cacc82b3d153eab02be2546ef34fa3580ed14137bb26224c"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://llvm.org/"
PKG_URL="http://llvm.org/releases/$PKG_VERSION/${PKG_NAME}-${PKG_VERSION}.src.tar.xz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain llvm:host zlib"
PKG_LONGDESC="Low-Level Virtual Machine (LLVM) is a compiler infrastructure."

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
                       -DLLVM_APPEND_VC_REV=OFF \
                       -DLLVM_ENABLE_RTTI=ON"

PKG_CMAKE_OPTS_HOST="$PKG_CMAKE_OPTS_COMMON \
                     -DCMAKE_INSTALL_RPATH=$TOOLCHAIN/lib"

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_COMMON \
                         -DCMAKE_BUILD_TYPE=MinSizeRel \
                         -DCMAKE_C_FLAGS="$CFLAGS" \
                         -DCMAKE_CXX_FLAGS="$CXXFLAGS" \
                         -DLLVM_TARGET_ARCH="$TARGET_ARCH" \
                         -DLLVM_TABLEGEN=$TOOLCHAIN/bin/llvm-tblgen"
}

make_host() {
  ninja $NINJA_OPTS llvm-config llvm-tblgen
}

makeinstall_host() {
  cp -a bin/llvm-config $SYSROOT_PREFIX/usr/bin/llvm-config-host
  cp -a bin/llvm-tblgen $TOOLCHAIN/bin
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/LLVMHello.so
  rm -rf $INSTALL/usr/lib/libLTO.so
  rm -rf $INSTALL/usr/share
}
