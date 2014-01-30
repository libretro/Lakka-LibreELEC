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

PKG_NAME="gcc"
PKG_VERSION="4.8.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://gcc.gnu.org/"
PKG_URL="ftp://ftp.gnu.org/gnu/gcc/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_BOOTSTRAP="ccache:host autoconf-2.64:host binutils:host gmp:host mpfr:host mpc:host cloog:host ppl:host"
PKG_DEPENDS_TARGET="gcc:host"
PKG_DEPENDS_HOST="ccache:host autoconf-2.64:host binutils:host gmp:host mpfr:host mpc:host cloog:host ppl:host eglibc"
PKG_PRIORITY="optional"
PKG_SECTION="lang"
PKG_SHORTDESC="gcc: The GNU Compiler Collection Version 4 (aka GNU C Compiler)"
PKG_LONGDESC="This package contains the GNU Compiler Collection. It includes compilers for the languages C, C++, Objective C, Fortran 95, Java and others ... This GCC contains the Stack-Smashing Protector Patch which can be enabled with the -fstack-protector command-line option. More information about it ca be found at http://www.research.ibm.com/trl/projects/security/ssp/."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

BOOTSTRAP_CONFIGURE_OPTS="--host=$HOST_NAME \
                          --build=$HOST_NAME \
                          --target=$TARGET_NAME \
                          --prefix=$ROOT/$TOOLCHAIN \
                          --with-sysroot=$SYSROOT_PREFIX \
                          --with-gmp=$ROOT/$TOOLCHAIN \
                          --with-mpfr=$ROOT/$TOOLCHAIN \
                          --with-mpc=$ROOT/$TOOLCHAIN \
                          --with-ppl=$ROOT/$TOOLCHAIN \
                          --disable-ppl-version-check \
                          --with-cloog=$ROOT/$TOOLCHAIN \
                          --with-gnu-as \
                          --with-gnu-ld \
                          --enable-languages=c \
                          --disable-__cxa_atexit \
                          --disable-libada \
                          --disable-libmudflap \
                          --disable-libatomic \
                          --enable-gold \
                          --enable-ld=default \
                          --enable-plugin \
                          --enable-lto \
                          --disable-libquadmath \
                          --disable-libssp \
                          --disable-libgomp \
                          --enable-cloog-backend=isl \
                          --disable-shared \
                          --disable-multilib \
                          --disable-threads \
                          --without-headers \
                          --with-newlib \
                          --disable-decimal-float \
                          $GCC_OPTS \
                          --disable-nls \
                          --disable-cloog-version-check"

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --with-sysroot=$SYSROOT_PREFIX \
                         --with-gmp=$ROOT/$TOOLCHAIN \
                         --with-mpfr=$ROOT/$TOOLCHAIN \
                         --with-mpc=$ROOT/$TOOLCHAIN \
                         --with-ppl=$ROOT/$TOOLCHAIN \
                         --disable-ppl-version-check \
                         --with-cloog=$ROOT/$TOOLCHAIN \
                         --enable-languages=${TOOLCHAIN_LANGUAGES} \
                         --with-gnu-as \
                         --with-gnu-ld \
                         --enable-__cxa_atexit \
                         --disable-libada \
                         --enable-decimal-float \
                         --disable-libmudflap \
                         --disable-libssp \
                         --disable-multilib \
                         --disable-libatomic \
                         --enable-gold \
                         --enable-ld=default \
                         --enable-plugin \
                         --enable-lto \
                         --disable-libquadmath \
                         --enable-cloog-backend=isl \
                         --enable-tls \
                         --enable-shared \
                         --enable-c99 \
                         --enable-long-long \
                         --enable-threads=posix \
                         --disable-libstdcxx-pch \
                         --enable-clocale=gnu \
                         $GCC_OPTS \
                         --disable-nls \
                         --disable-cloog-version-check"

pre_configure_bootstrap() {
  setup_toolchain host
}

makeinstall_bootstrap() {
  make install
}

post_make_host() {
  # fix wrong link
  rm -rf $TARGET_NAME/libgcc/libgcc_s.so
  ln -sf libgcc_s.so.1 $TARGET_NAME/libgcc/libgcc_s.so

  if [ ! "$DEBUG" = yes ]; then
    $TARGET_STRIP $TARGET_NAME/libgcc/libgcc_s.so*
    $TARGET_STRIP $TARGET_NAME/libgomp/.libs/libgomp.so*
    $TARGET_STRIP $TARGET_NAME/libitm/.libs/libitm.so*
    $TARGET_STRIP $TARGET_NAME/libstdc++-v3/src/.libs/libstdc++.so*
  fi
}

post_makeinstall_host() {
  cp -PR $TARGET_NAME/libstdc++-v3/src/.libs/libstdc++.so* $SYSROOT_PREFIX/usr/lib

  GCC_VERSION=`$ROOT/$TOOLCHAIN/$TARGET_NAME/bin/gcc -dumpversion`
  DATE="0501`echo $GCC_VERSION | sed 's/\([0-9]\)/0\1/g' | sed 's/\.//g'`"
  CROSS_CC=$TARGET_CC-$GCC_VERSION
  CROSS_CXX=$TARGET_CXX-$GCC_VERSION

  rm -f $TARGET_CC

cat > $TARGET_CC <<EOF
#!/bin/sh
$ROOT/$TOOLCHAIN/bin/ccache $CROSS_CC "\$@"
EOF

  chmod +x $TARGET_CC

  # To avoid cache trashing
  touch -c -t $DATE $CROSS_CC

  [ ! -f "$CROSS_CXX" ] && mv $TARGET_CXX $CROSS_CXX

cat > $TARGET_CXX <<EOF
#!/bin/sh
$ROOT/$TOOLCHAIN/bin/ccache $CROSS_CXX "\$@"
EOF

  chmod +x $TARGET_CXX

  # To avoid cache trashing
  touch -c -t $DATE $CROSS_CXX
}

configure_target() {
 : # reuse configure_host()
}

make_target() {
 : # reuse make_host()
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
    cp -P $ROOT/$PKG_BUILD/.$HOST_NAME/$TARGET_NAME/libgcc/libgcc_s.so* $INSTALL/usr/lib
    cp -P $ROOT/$PKG_BUILD/.$HOST_NAME/$TARGET_NAME/libgomp/.libs/libgomp.so* $INSTALL/usr/lib
    cp -P $ROOT/$PKG_BUILD/.$HOST_NAME/$TARGET_NAME/libstdc++-v3/src/.libs/libstdc++.so* $INSTALL/usr/lib
}

configure_init() {
 : # reuse configure_host()
}

make_init() {
 : # reuse make_host()
}

makeinstall_init() {
  mkdir -p $INSTALL/lib
    cp -P $ROOT/$PKG_BUILD/.$HOST_NAME/$TARGET_NAME/libgcc/libgcc_s.so* $INSTALL/lib
}
