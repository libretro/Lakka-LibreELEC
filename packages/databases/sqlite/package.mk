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

PKG_NAME="sqlite"
PKG_VERSION="autoconf-3220000"
PKG_SHA256="2824ab1238b706bc66127320afbdffb096361130e23291f26928a027b885c612"
PKG_ARCH="any"
PKG_LICENSE="PublicDomain"
PKG_SITE="https://www.sqlite.org/"
PKG_URL="https://www.sqlite.org/2018/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="database"
PKG_SHORTDESC="sqlite: An Embeddable SQL Database Engine"
PKG_LONGDESC="SQLite is a C library that implements an embeddable SQL database engine. Programs that link with the SQLite library can have SQL database access without running a separate RDBMS process. The distribution comes with a standalone command-line access program (sqlite) that can be used to administer an SQLite database and which serves as an example of how to use the SQLite library. SQLite is not a client library used to connect to a big database server. SQLite is the server. The SQLite library reads and writes directly to and from the database files on disk."
# libsqlite3.a(sqlite3.o): requires dynamic R_X86_64_PC32 reloc against 'sqlite3_stricmp' which may overflow at runtime
PKG_BUILD_FLAGS="+pic +pic:host -parallel"

# sqlite fails to compile with fast-math link time optimization.
  CFLAGS=`echo $CFLAGS | sed -e "s|-Ofast|-O3|g"`
  CFLAGS=`echo $CFLAGS | sed -e "s|-ffast-math||g"`

# This option adds additional logic to the ANALYZE command and to the query planner
# that can help SQLite to chose a better query plan under certain situations. The
# ANALYZE command is enhanced to collect histogram data from each index and store
# that data in the sqlite_stat3 table. The query planner will then use the histogram
# data to help it make better index choices.
  CFLAGS="$CFLAGS -DSQLITE_ENABLE_STAT3"

# When this C-preprocessor macro is defined, SQLite includes some additional APIs
# that provide convenient access to meta-data about tables and queries. The APIs that
# are enabled by this option are:
#  - sqlite3_column_database_name()
#  - sqlite3_column_database_name16()
#  - sqlite3_column_table_name()
#  - sqlite3_column_table_name16()
#  - sqlite3_column_origin_name()
#  - sqlite3_column_origin_name16()
#  - sqlite3_table_column_metadata()
  CFLAGS="$CFLAGS -DSQLITE_ENABLE_COLUMN_METADATA=1"

# This macro sets the default limit on the amount of memory that will be used for
# memory-mapped I/O for each open database file. If the N is zero, then memory
# mapped I/O is disabled by default. This compile-time limit and the
# SQLITE_MAX_MMAP_SIZE can be modified at start-time using the
# sqlite3_config(SQLITE_CONFIG_MMAP_SIZE) call, or at run-time using the
# mmap_size pragma.
  CFLAGS="$CFLAGS -DSQLITE_TEMP_STORE=3 -DSQLITE_DEFAULT_MMAP_SIZE=268435456"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-readline \
                           --enable-threadsafe \
                           --enable-dynamic-extensions \
                           --with-gnu-ld"
