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

PKG_NAME="Python"
PKG_VERSION="2.7.13"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.python.org/"
PKG_URL="http://www.python.org/ftp/python/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="zlib:host bzip2:host sqlite:host"
PKG_DEPENDS_TARGET="toolchain sqlite expat zlib bzip2 openssl libffi Python:host"
PKG_SECTION="lang"
PKG_SHORTDESC="python: The Python programming language"
PKG_LONGDESC="Python is an interpreted object-oriented programming language, and is often compared with Tcl, Perl, Java or Scheme."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PY_DISABLED_MODULES="_tkinter nis gdbm bsddb ossaudiodev"

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
                           ac_cv_file__dev_ptmx=no \
                           ac_cv_file__dev_ptc=no \
                           ac_cv_have_long_long_format=yes \
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
post_patch() {
  # This is needed to make sure the Python build process doesn't try to
  # regenerate those files with the pgen program. Otherwise, it builds
  # pgen for the target, and tries to run it on the host.
    touch $PKG_BUILD/Include/graminit.h
    touch $PKG_BUILD/Python/graminit.c
}

make_host() {
  make PYTHON_MODULES_INCLUDE="$HOST_INCDIR" \
       PYTHON_MODULES_LIB="$HOST_LIBDIR" \
       PYTHON_DISABLE_MODULES="readline _curses _curses_panel $PY_DISABLED_MODULES"

  # python distutils per default adds -L$LIBDIR when linking binary extensions
    sed -e "s|^ 'LIBDIR':.*| 'LIBDIR': '/usr/lib',|g" -i $(cat pybuilddir.txt)/_sysconfigdata.py
}

makeinstall_host() {
  make -j1 PYTHON_MODULES_INCLUDE="$HOST_INCDIR" \
       PYTHON_MODULES_LIB="$HOST_LIBDIR" \
       PYTHON_DISABLE_MODULES="readline _curses _curses_panel $PY_DISABLED_MODULES" \
       install
}

pre_configure_target() {
  export PYTHON_FOR_BUILD=$TOOLCHAIN/bin/python
}

make_target() {
  make  -j1 CC="$CC" LDFLAGS="$TARGET_LDFLAGS -L." \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        PYTHON_MODULES_INCLUDE="$TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$TARGET_LIBDIR"
}

makeinstall_target() {
  make  -j1 CC="$CC" DESTDIR=$SYSROOT_PREFIX \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        PYTHON_MODULES_INCLUDE="$TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$TARGET_LIBDIR" \
        install

  make  -j1 CC="$CC" DESTDIR=$INSTALL \
        PYTHON_DISABLE_MODULES="$PY_DISABLED_MODULES" \
        PYTHON_MODULES_INCLUDE="$TARGET_INCDIR" \
        PYTHON_MODULES_LIB="$TARGET_LIBDIR" \
        install
}

post_makeinstall_target() {
  EXCLUDE_DIRS="bsddb idlelib lib-tk lib2to3 msilib pydoc_data test unittest"
  for dir in $EXCLUDE_DIRS; do
    rm -rf $INSTALL/usr/lib/python*/$dir
  done

  rm -rf $INSTALL/usr/lib/python*/config
  rm -rf $INSTALL/usr/bin/2to3
  rm -rf $INSTALL/usr/bin/idle
  rm -rf $INSTALL/usr/bin/pydoc
  rm -rf $INSTALL/usr/bin/smtpd.py
  rm -rf $INSTALL/usr/bin/python*-config

  cd $INSTALL/usr/lib/python2.7
  python -Wi -t -B $PKG_BUILD/Lib/compileall.py -d /usr/lib/python2.7 -f .
  find $INSTALL/usr/lib/python2.7 -name "*.py" -exec rm -f {} \; &>/dev/null

  # strip
  chmod u+w $INSTALL/usr/lib/libpython*.so.*
  debug_strip $INSTALL/usr
}
