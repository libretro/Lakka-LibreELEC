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

PKG_NAME="mysql"
PKG_VERSION="5.1.73"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mysql.com"
PKG_URL="http://ftp.gwdg.de/pub/misc/$PKG_NAME/Downloads/MySQL-5.1/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib ncurses mysql:host"
PKG_PRIORITY="optional"
PKG_SECTION="database"
PKG_SHORTDESC="mysql: A database server"
PKG_LONGDESC="MySQL is a SQL (Structured Query Language) database server. SQL is the most popular database language in the world. MySQL is a client server implementation that consists of a server daemon mysqld and many different client programs/libraries."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

TARGET_CFLAGS="$TARGET_CFLAGS -fPIC -DPIC -I$SYSROOT_PREFIX/usr/include/ncurses"

PKG_CONFIGURE_OPTS_HOST="--with-zlib-dir=$ROOT/$TOOLCHAIN"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_c_stack_direction=-1 \
                           ac_cv_sys_restartable_syscalls=yes \
                           --localstatedir=/storage/.mysql \
                           --with-unix-socket-path=/var/tmp/mysql.socket \
                           --with-tcp-port=3306 \
                           --enable-static \
                           --disable-shared \
                           --with-low-memory \
                           --enable-largefile \
                           --with-big-tables \
                           --with-mysqld-user=mysqld \
                           --with-extra-charsets=all \
                           --with-pthread \
                           --with-named-thread-libs=-lpthread \
                           --enable-thread-safe-client \
                           --enable-assembler \
                           --enable-local-infile \
                           --without-debug \
                           --without-docs \
                           --without-man \
                           --with-readline \
                           --without-libwrap \
                           --without-pstack \
                           --without-server \
                           --without-embedded-server \
                           --without-libedit \
                           --with-query-cache \
                           --without-plugin-partition \
                           --without-plugin-daemon_example \
                           --without-plugin-ftexample \
                           --without-plugin-archive \
                           --without-plugin-blackhole \
                           --without-plugin-example \
                           --without-plugin-federated \
                           --without-plugin-ibmdb2i \
                           --without-plugin-innobase \
                           --without-plugin-innodb_plugin \
                           --without-plugin-ndbcluster"

make_host() {
  make -C include my_config.h
  make -C mysys libmysys.a
  make -C strings libmystrings.a
  make -C dbug factorial
  make -C vio libvio.a
  make -C dbug libdbug.a
  make -C regex libregex.a
  make -C sql gen_lex_hash
  make -C scripts comp_sql
  make -C extra comp_err
}

makeinstall_host() {
  cp -PR dbug/factorial $ROOT/$TOOLCHAIN/bin/mysql-factorial
  cp -PR sql/gen_lex_hash $ROOT/$TOOLCHAIN/bin/mysql-gen_lex_hash
  cp -PR scripts/comp_sql $ROOT/$TOOLCHAIN/bin/mysql-comp_sql
  cp -PR extra/comp_err $ROOT/$TOOLCHAIN/bin/mysql-comp_err
}

post_makeinstall_target() {
  sed -i "s|pkgincludedir=.*|pkgincludedir=\'$SYSROOT_PREFIX/usr/include/mysql\'|" scripts/mysql_config
  sed -i "s|pkglibdir=.*|pkglibdir=\'$SYSROOT_PREFIX/usr/lib/mysql\'|" scripts/mysql_config
  cp scripts/mysql_config $SYSROOT_PREFIX/usr/bin
  ln -sf $SYSROOT_PREFIX/usr/bin/mysql_config $ROOT/$TOOLCHAIN/bin/mysql_config

  for i in `ls -d $SYSROOT_PREFIX/usr/lib/mysql/*.a`; do 
    ln -v -sf $i $SYSROOT_PREFIX/usr/lib
  done

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/mysql-test
  rm -rf $INSTALL/usr/share/mysql
  rm -rf $INSTALL/usr/sql-bench
}
