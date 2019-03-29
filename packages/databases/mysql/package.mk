# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mysql"
PKG_VERSION="5.7.20"
PKG_SHA256="5397549bb7c238f396c123db2df4cad2191b11adf8986de7fe63bff8e2786487"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mysql.com"
PKG_URL="http://ftp.gwdg.de/pub/misc/$PKG_NAME/Downloads/MySQL-5.7/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain zlib:host"
PKG_DEPENDS_TARGET="toolchain zlib ncurses openssl boost mysql:host"
PKG_LONGDESC="A SQL database server."

PKG_CMAKE_OPTS_HOST="-DCMAKE_BUILD_TYPE=Release \
                     -DSTACK_DIRECTION=-1 \
                     -DHAVE_LLVM_LIBCPP_EXITCODE=0 \
                     -DHAVE_FALLOC_PUNCH_HOLE_AND_KEEP_SIZE_EXITCODE=0 \
                     -DWITHOUT_SERVER=OFF \
                     -DWITH_EMBEDDED_SERVER=OFF \
                     -DWITH_INNOBASE_STORAGE_ENGINE=OFF \
                     -DWITH_PARTITION_STORAGE_ENGINE=OFF \
                     -DWITH_PERFSCHEMA_STORAGE_ENGINE=OFF \
                     -DWITH_EXTRA_CHARSETS=none \
                     -DWITH_EDITLINE=bundled \
                     -DWITH_LIBEVENT=bundled \
                     -DDOWNLOAD_BOOST=0 \
                     -DLOCAL_BOOST_DIR=$(get_build_dir boost) \
                     -DWITH_UNIT_TESTS=OFF \
                     -DWITH_ZLIB=bundled"

PKG_CMAKE_OPTS_TARGET="-DINSTALL_INCLUDEDIR=include/mysql \
                       -DCMAKE_BUILD_TYPE=Release \
                       -DFEATURE_SET=classic \
                       -DDISABLE_SHARED=ON \
                       -DENABLE_DTRACE=OFF \
                       -DWITH_EMBEDDED_SERVER=OFF \
                       -DWITH_INNOBASE_STORAGE_ENGINE=OFF \
                       -DWITH_PARTITION_STORAGE_ENGINE=OFF \
                       -DWITH_PERFSCHEMA_STORAGE_ENGINE=OFF \
                       -DWITH_EXTRA_CHARSETS=all \
                       -DWITH_UNIT_TESTS=OFF \
                       -DWITHOUT_SERVER=ON \
                       -DWITH_EDITLINE=bundled \
                       -DWITH_LIBEVENT=bundled \
                       -DWITH_ZLIB=system \
                       -DWITH_SSL=$SYSROOT_PREFIX/usr \
                       -DDOWNLOAD_BOOST=0 \
                       -DLOCAL_BOOST_DIR=$(get_build_dir boost) \
                       -DSTACK_DIRECTION=1 \
                       -DHAVE_LLVM_LIBCPP=1"

post_unpack() {
  sed -i 's|GET_TARGET_PROPERTY(LIBMYSQL_OS_OUTPUT_NAME libmysql OUTPUT_NAME)|SET(LIBMYSQL_OS_OUTPUT_NAME "mysqlclient")|' $PKG_BUILD/scripts/CMakeLists.txt
  sed -i "s|COMMAND comp_err|COMMAND $TOOLCHAIN/bin/comp_err|" $PKG_BUILD/extra/CMakeLists.txt
  sed -i "s|COMMAND comp_sql|COMMAND $TOOLCHAIN/bin/comp_sql|" $PKG_BUILD/scripts/CMakeLists.txt
  sed -i "s|COMMAND gen_lex_hash|COMMAND $TOOLCHAIN/bin/gen_lex_hash|" $PKG_BUILD/sql/CMakeLists.txt

  sed -i '/^IF(NOT BOOST_MINOR_VERSION.*$/,/^ENDIF()$/d' $PKG_BUILD/cmake/boost.cmake
}

make_host() {
  ninja comp_err
  ninja gen_lex_hash
  ninja comp_sql
}

post_make_host() {
  # needed so the binary isn't built for target
  cp scripts/comp_sql ../scripts/comp_sql
}

makeinstall_host() {
  cp -P extra/comp_err $TOOLCHAIN/bin
  cp -P sql/gen_lex_hash $TOOLCHAIN/bin
  cp -P scripts/comp_sql $TOOLCHAIN/bin
}

post_makeinstall_target() {
  sed -i "s|pkgincludedir=.*|pkgincludedir=\'$SYSROOT_PREFIX/usr/include/mysql\'|" scripts/mysql_config
  sed -i "s|pkglibdir=.*|pkglibdir=\'$SYSROOT_PREFIX/usr/lib/mysql\'|" scripts/mysql_config
  cp scripts/mysql_config $SYSROOT_PREFIX/usr/bin
  cp scripts/mysql_config $TOOLCHAIN/bin/mysql_config

  rm -rf $INSTALL
}
