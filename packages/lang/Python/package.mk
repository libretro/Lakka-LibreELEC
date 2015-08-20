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

PKG_NAME="Python"
PKG_VERSION="2.7.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.python.org/"
PKG_URL="http://www.python.org/ftp/python/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="zlib:host"
PKG_DEPENDS_TARGET="toolchain Python:host sqlite expat zlib bzip2 libressl libffi"
PKG_PRIORITY="optional"
PKG_SECTION="lang"
PKG_SHORTDESC="python: The Python programming language"
PKG_LONGDESC="Python is an interpreted object-oriented programming language, and is often compared with Tcl, Perl, Java or Scheme."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PY_DISABLED_MODULES="readline _curses _curses_panel _tkinter nis gdbm bsddb ossaudiodev"

PKG_CONFIGURE_OPTS_HOST="--cache-file=config.cache \
                         --without-cxx-main \
                         --with-threads \
                         --enable-unicode=ucs4"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_file_dev_ptc=no \
                           ac_cv_file_dev_ptmx=yes \
                           ac_cv_func_lchflags_works=no \
                           ac_cv_func_chflags_works=no \
                           ac_cv_func_printf_zd=yes \
                           ac_cv_buggy_getaddrinfo=no \
                           ac_cv_header_bluetooth_bluetooth_h=no \
                           ac_cv_header_bluetooth_h=no \
                           --with-threads \
                           --enable-unicode=ucs4 \
                           --enable-ipv6 \
                           --disable-profiling \
                           --without-pydebug \
                           --without-doc-strings \
                           --without-tsc \
                           --with-pymalloc \
                           --without-fpectl \
                           --with-wctype-functions \
                           --without-cxx-main \
                           --with-system-ffi \
                           --with-system-expat"

pre_configure_host() {
  export OPT="$HOST_CFLAGS"
}

make_host() {
  make PYTHON_MODULES_INCLUDE="$HOST_INCDIR" \
       PYTHON_MODULES_LIB="$HOST_LIBDIR" \
       PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES"
}

make_target() {
  make  -j1 CC="$TARGET_CC" \
        HOSTPYTHON=$ROOT/$TOOLCHAIN/bin/python \
        HOSTPGEN=$ROOT/$TOOLCHAIN/bin/pgen \
        BLDSHARED="$CC -shared" \
        RUNSHARED="LD_LIBRARY_PATH=$ROOT/$TOOLCHAIN/lib:$LD_LIBRARY_PATH" \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        CROSS_COMPILE="$TARGET_NAME" \
        CROSS_COMPILE_TARGET="yes" \
        PYTHON_MODULES_INCLUDE="$TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$TARGET_LIBDIR"
}

makeinstall_host() {
  make PYTHON_MODULES_INCLUDE="$HOST_INCDIR" \
       PYTHON_MODULES_LIB="$HOST_LIBDIR" \
       PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
       install

  cp Parser/pgen $ROOT/$TOOLCHAIN/bin

# replace python-config to make sure python uses $SYSROOT_PREFIX
  mkdir -p $ROOT/$TOOLCHAIN/bin
    rm -rf $ROOT/$TOOLCHAIN/bin/python*-config

    sed -e "s:%PREFIX%:$SYSROOT_PREFIX/usr:g" -e "s:%CFLAGS%:$TARGET_CFLAGS:g" \
      $PKG_DIR/scripts/python-config > $ROOT/$TOOLCHAIN/bin/python2.7-config
    chmod +x $ROOT/$TOOLCHAIN/bin/python2.7-config
    ln -s python2.7-config $ROOT/$TOOLCHAIN/bin/python-config
}

makeinstall_target() {
  make  -j1 CC="$TARGET_CC" \
        DESTDIR=$SYSROOT_PREFIX \
        HOSTPYTHON=$ROOT/$TOOLCHAIN/bin/python \
        HOSTPGEN=$ROOT/$TOOLCHAIN/bin/pgen \
        BLDSHARED="$CC -shared" \
        RUNSHARED="LD_LIBRARY_PATH=$ROOT/$TOOLCHAIN/lib:$LD_LIBRARY_PATH" \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        CROSS_COMPILE="$TARGET_NAME" \
        CROSS_COMPILE_TARGET="yes" \
        PYTHON_MODULES_INCLUDE="$TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$TARGET_LIBDIR" \
        install

# python distutils per default adds -L$LIBDIR when linking binary extensions
  sed -e "s|^LIBDIR=.*|LIBDIR= $SYSROOT_PREFIX/usr/lib|" \
      -i $SYSROOT_PREFIX/usr/lib/python*/config/Makefile

  make  -j1 CC="$TARGET_CC" \
        DESTDIR=$INSTALL \
        HOSTPYTHON=$ROOT/$TOOLCHAIN/bin/python \
        HOSTPGEN=$ROOT/$TOOLCHAIN/bin/pgen \
        BLDSHARED="$CC -shared" \
        RUNSHARED="LD_LIBRARY_PATH=$ROOT/$TOOLCHAIN/lib:$LD_LIBRARY_PATH" \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        CROSS_COMPILE="$TARGET_NAME" \
        CROSS_COMPILE_TARGET="yes" \
        PYTHON_MODULES_INCLUDE="$TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$TARGET_LIBDIR" \
        install
}

post_makeinstall_target() {
  EXCLUDE_DIRS="bsddb curses idlelib lib-tk lib2to3 msilib pydoc_data test unittest"
  for dir in $EXCLUDE_DIRS; do
    rm -rf $INSTALL/usr/lib/python*/$dir
  done

  python -Wi -t -B ../Lib/compileall.py $INSTALL/usr/lib/python*/ -f
  rm -rf `find $INSTALL/usr/lib/python*/ -name "*.py"`

  rm -rf $INSTALL/usr/lib/python*/config/Setup*
  rm -rf $INSTALL/usr/lib/python*/config/config.*
  rm -rf $INSTALL/usr/lib/python*/config/install-sh
  rm -rf $INSTALL/usr/lib/python*/config/makesetup
  rm -rf $INSTALL/usr/lib/python*/config/python.o

  if [ ! -f $INSTALL/usr/lib/python*/lib-dynload/_socket.so ]; then
    echo "sometimes Python dont build '_socket.so' for some reasons and continues without failing,"
    echo "let it fail here, to be sure '_socket.so' will be installed. A rebuild of Python fixes"
    echo "the issue in most cases"
    exit 1
  fi

  # k0p
  rm -rf $INSTALL/usr/bin/2to3
  rm -rf $INSTALL/usr/bin/idle
  rm -rf $INSTALL/usr/bin/pydoc
  rm -rf $INSTALL/usr/bin/smtpd.py
  rm -rf $INSTALL/usr/bin/python*-config
}
