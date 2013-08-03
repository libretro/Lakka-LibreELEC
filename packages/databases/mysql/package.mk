################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="mysql"
PKG_VERSION="5.6.13"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mysql.com"
PKG_URL="http://cdn.mysql.com/Downloads/MySQL-5.6/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS="zlib ncurses"
PKG_BUILD_DEPENDS_HOST="toolchain zlib openssl ncurses"
PKG_BUILD_DEPENDS_TARGET="toolchain zlib openssl ncurses mysql:host"
PKG_PRIORITY="optional"
PKG_SECTION="database"
PKG_SHORTDESC="mysql: A database server"
PKG_LONGDESC="MySQL is a SQL (Structured Query Language) database server. SQL is the most popular database language in the world. MySQL is a client server implementation that consists of a server daemon mysqld and many different client programs/libraries."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_host() {
  sed -i "/ADD_SUBDIRECTORY(sql\/share)/d" ../CMakeLists.txt
  sed -i "s/ADD_SUBDIRECTORY(libmysql)/&\\nADD_SUBDIRECTORY(sql\/share)/" ../CMakeLists.txt
  sed -i "s@data/test@\${INSTALL_MYSQLSHAREDIR}@g" ../sql/CMakeLists.txt
  sed -i "s@data/mysql@\${INSTALL_MYSQLTESTDIR}@g" ../sql/CMakeLists.txt
}

# package specific configure options
configure_host() {
  cmake -DCMAKE_INSTALL_PREFIX=$TOOLCHAIN             \
        -DCMAKE_BUILD_TYPE=Release                    \
        -DWITHOUT_SERVER=OFF                          \
        -DWITH_EMBEDDED_SERVER=OFF                    \
        -DWITH_EXTRA_CHARSETS=none                    \
        -DWITH_EDITLINE=bundled                       \
        -DWITH_LIBEVENT=bundled                       \
        -DWITH_SSL=bundled                            \
        -DWITH_UNIT_TESTS=OFF                         \
        -DWITH_ZLIB=bundled                           \
        ..
}

make_host() {
  make comp_err
  make gen_lex_hash
  make comp_sql
  make gen_pfs_lex_token
}

makeinstall_host() {
  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp -PR extra/comp_err $ROOT/$TOOLCHAIN/bin
    cp -PR sql/gen_lex_hash $ROOT/$TOOLCHAIN/bin
    cp -PR scripts/comp_sql $ROOT/$TOOLCHAIN/bin
    cp -PR storage/perfschema/gen_pfs_lex_token $ROOT/$TOOLCHAIN/bin
}

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF            \
        -DCMAKE_BUILD_TYPE=Release                    \
        -DFEATURE_SET=community                       \
        -DDISABLE_SHARED=ON                           \
        -DCMAKE_INSTALL_PREFIX=/usr                   \
        -DINSTALL_DOCDIR=share/doc/mysql              \
        -DINSTALL_DOCREADMEDIR=share/doc/mysql        \
        -DINSTALL_INCLUDEDIR=include/mysql            \
        -DINSTALL_INFODIR=share/info                  \
        -DINSTALL_MANDIR=share/man                    \
        -DINSTALL_MYSQLDATADIR=/storage/.mysql        \
        -DINSTALL_MYSQLSHAREDIR=share/mysql           \
        -DINSTALL_MYSQLTESTDIR=share/mysql/test       \
        -DINSTALL_PLUGINDIR=lib/mysql/plugin          \
        -DINSTALL_SBINDIR=sbin                        \
        -DINSTALL_SCRIPTDIR=bin                       \
        -DINSTALL_SQLBENCHDIR=share/mysql/bench       \
        -DINSTALL_SUPPORTFILESDIR=share/mysql/support \
        -DMYSQL_DATADIR=/storage/.mysql               \
        -DMYSQL_UNIX_ADDR=/run/mysqld/mysqld.sock     \
        -DSYSCONFDIR=/etc/mysql                       \
        -DWITHOUT_SERVER=OFF                          \
        -DWITH_EMBEDDED_SERVER=OFF                    \
        -DWITH_PARTITION_STORAGE_ENGINE=OFF           \
        -DWITH_PERFSCHEMA_STORAGE_ENGINE=ON           \
        -DWITH_EXTRA_CHARSETS=all                     \
        -DENABLE_DTRACE=OFF                           \
        -DWITH_EDITLINE=bundled                       \
        -DWITH_LIBEVENT=bundled                       \
        -DWITH_SSL=system                             \
        -DWITH_UNIT_TESTS=OFF                         \
        -DWITH_ZLIB=system                            \
        -DSTACK_DIRECTION=1                           \
        ..
}

pre_make_target() {
# copy host binaries back - should be fixed
  cp -PR ../.$HOST_NAME/scripts/comp_sql ../scripts/comp_sql
}

post_makeinstall_target() {
  sed -i "s|pkgincludedir=.*|pkgincludedir=\'$SYSROOT_PREFIX/usr/include/mysql\'|" scripts/mysql_config
  sed -i "s|pkglibdir=.*|pkglibdir=\'$SYSROOT_PREFIX/usr/lib/mysql\'|" scripts/mysql_config

  mkdir -p $ROOT/$TOOLCHAIN/bin
    cp -PR scripts/mysql_config $ROOT/$TOOLCHAIN/bin

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/sbin
  rm -rf $INSTALL/usr/lib/mysql/plugin
  rm -rf $INSTALL/usr/share/mysql/bench
  rm -rf $INSTALL/usr/share/mysql/support
  rm -rf $INSTALL/usr/share/mysql/test

  if [ "$MYSQL_SERVER" = "yes" ]; then
    mkdir -p $INSTALL/usr/bin
      cp -P extra/resolveip $INSTALL/usr/bin
      cp -P extra/my_print_defaults $INSTALL/usr/bin
      cp -P client/mysql $INSTALL/usr/bin
      cp -P client/mysqladmin $INSTALL/usr/bin
      cp -P ../scripts/mysql_install_db.sh $INSTALL/usr/bin/mysql_install_db
        chmod +x $INSTALL/usr/bin/mysql_install_db
        sed -e 's,@localstatedir@,/storage/.mysql,g' \
            -e 's,@bindir@,/usr/bin,g' \
            -e 's,@prefix@,/usr,g' \
            -e 's,@libexecdir@,/usr/sbin,g' \
            -e 's,@pkgdatadir@,/usr/share/mysql,g' \
            -e 's,@scriptdir@,/usr/bin,g' \
            -e 's,^.basedir=.*,basedir="/usr",g' \
            -e 's,@HOSTNAME@,cat /proc/sys/kernel/hostname,g' \
            -i $INSTALL/usr/bin/mysql_install_db

    mkdir -p $INSTALL/usr/sbin
      cp -P sql/mysqld $INSTALL/usr/sbin

    mkdir -p $INSTALL/etc/init.d
      cp $PKG_DIR/scripts/* $INSTALL/etc/init.d
  else
    rm -rf $INSTALL/usr/share/mysql
  fi
}
