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

PKG_NAME="eglibc"
PKG_VERSION="2.19-25249"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.eglibc.org/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="ccache:host autotools:host autoconf:host linux:host gcc:bootstrap"
PKG_DEPENDS_INIT="eglibc"
PKG_PRIORITY="optional"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="eglibc: The Embedded GNU C library"
PKG_LONGDESC="The Embedded GLIBC (EGLIBC) is a variant of the GNU C Library (GLIBC) that is designed to work well on embedded systems. EGLIBC strives to be source and binary compatible with GLIBC. EGLIBC's goals include reduced footprint, configurable components, better support for cross-compilation and cross-testing. In contrast to what Ulrich Drepper makes out of GLIBC, in EGLIBC all patches assigned to the FSF will be considered regardless of individual or company affiliation and cooperation is encouraged, as well as communication, civility, and respect among developers."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="BASH_SHELL=/bin/sh \
                           --libexecdir=/usr/lib/eglibc \
                           --cache-file=config.cache \
                           --disable-profile \
                           --disable-sanity-checks \
                           --enable-add-ons \
                           --enable-bind-now \
                           --with-elf \
                           --with-tls \
                           --with-__thread \
                           --with-binutils=$BUILD/toolchain/bin \
                           --with-headers=$SYSROOT_PREFIX/usr/include \
                           --enable-kernel=3.0.0 \
                           --without-cvs \
                           --without-gd \
                           --enable-obsolete-rpc \
                           --disable-build-nscd \
                           --disable-nscd \
                           --enable-lock-elision"

if [ "$DEBUG" = yes ]; then
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --enable-debug"
else
  PKG_CONFIGURE_OPTS_TARGET="$PKG_CONFIGURE_OPTS_TARGET --disable-debug"
  DEBUG_OPTIONS="  OPTION_EGLIBC_MEMUSAGE = n"
fi

NSS_CONF_DIR="$PKG_BUILD/nss"

EGLIBC_EXCLUDE_BIN="catchsegv getconf iconv iconvconfig ldconfig lddlibc4"
EGLIBC_EXCLUDE_BIN="$EGLIBC_EXCLUDE_BIN localedef makedb mtrace pcprofiledump"
EGLIBC_EXCLUDE_BIN="$EGLIBC_EXCLUDE_BIN pldd rpcgen sln sotruss sprof tzselect"
EGLIBC_EXCLUDE_BIN="$EGLIBC_EXCLUDE_BIN xtrace zdump zic"

pre_build_target() {
  cd $PKG_BUILD
    aclocal --force --verbose
    autoconf --force --verbose
  cd -
}

pre_configure_target() {
# Fails to compile with GCC's link time optimization.
  strip_lto

# eglibc dont support GOLD linker.
  strip_gold

# Filter out some problematic *FLAGS
  export CFLAGS=`echo $CFLAGS | sed -e "s|-ffast-math||g"`
  export CFLAGS=`echo $CFLAGS | sed -e "s|-Ofast|-O2|g"`
  export CFLAGS=`echo $CFLAGS | sed -e "s|-O.|-O2|g"`

  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-ffast-math||g"`
  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-Ofast|-O2|g"`
  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-O.|-O2|g"`

  export LDFLAGS=`echo $LDFLAGS | sed -e "s|-Wl,--as-needed||"`

  unset LD_LIBRARY_PATH

# set some CFLAGS we need
  export CFLAGS="$CFLAGS -g -fno-stack-protector -fgnu89-inline"

# dont build parallel
  export MAKEFLAGS=-j1

  export BUILD_CC=$HOST_CC
  export OBJDUMP_FOR_HOST=objdump

# create configuration
cat >option-groups.config <<EOF

  OPTION_EGLIBC_ADVANCED_INET6 = n

# needed for connman:
  OPTION_EGLIBC_BACKTRACE = y

  OPTION_EGLIBC_BIG_MACROS = n
  OPTION_EGLIBC_BSD = n
  OPTION_EGLIBC_CATGETS = n

# libiconv replacement:
  OPTION_EGLIBC_CHARSETS = y

  OPTION_EGLIBC_DB_ALIASES = n
  OPTION_EGLIBC_LOCALES = n

# needed for example with glib and Python:
  OPTION_EGLIBC_LOCALE_CODE = y

# activeperl fails without libnsl. keep it enabled for now
  OPTION_EGLIBC_NIS = y
  OPTION_EGLIBC_NSSWITCH = y
  OPTION_EGLIBC_RCMD = n

# needed by eglibc byself (todo):
  OPTION_EGLIBC_RTLD_DEBUG = y

# needed for speed (optionally/todo)
  OPTION_POSIX_REGEXP_GLIBC = y

# needed for PAM and Mysql:
  OPTION_EGLIBC_GETLOGIN = y

# needed for systemd and dropbear:
  OPTION_EGLIBC_UTMP = y
  OPTION_EGLIBC_UTMPX = y

# debugging options:
  $DEBUG_OPTIONS
EOF

cat >config.cache <<EOF
ac_cv_header_cpuid_h=yes
libc_cv_forced_unwind=yes
libc_cv_c_cleanup=yes
libc_cv_gnu89_inline=yes
libc_cv_ssp=no
libc_cv_ctors_header=yes
EOF

echo "libdir=/usr/lib" >> configparms
echo "slibdir=/lib" >> configparms
echo "sbindir=/usr/bin" >> configparms
echo "rootsbindir=/usr/bin" >> configparms
}

post_makeinstall_target() {
# we are linking against ld.so, so symlink
  ln -sf $(basename $INSTALL/lib/ld-*.so) $INSTALL/lib/ld.so

# cleanup
  for i in $EGLIBC_EXCLUDE_BIN; do
    rm -rf $INSTALL/usr/bin/$i
  done
  rm -rf $INSTALL/usr/lib/audit
  rm -rf $INSTALL/usr/lib/eglibc
  rm -rf $INSTALL/usr/lib/libc_pic
  rm -rf $INSTALL/usr/lib/*.o
  rm -rf $INSTALL/usr/lib/*.map
  rm -rf $INSTALL/var

# create default configs
  mkdir -p $INSTALL/etc
    cp $PKG_DIR/config/nsswitch.conf $INSTALL/etc
    cp $PKG_DIR/config/host.conf $INSTALL/etc
    cp $PKG_DIR/config/gai.conf $INSTALL/etc

  if [ "$TARGET_ARCH" = "arm" -a "$TARGET_FLOAT" = "hard" ]; then
    ln -sf ld.so $INSTALL/lib/ld-linux.so.3
  fi
}

configure_init() {
  cd $ROOT/$PKG_BUILD
    rm -rf $ROOT/$PKG_BUILD/.$TARGET_NAME-init
}

make_init() {
  : # reuse make_target()
}

makeinstall_init() {
  mkdir -p $INSTALL/lib
    cp -PR $ROOT/$PKG_BUILD/.$TARGET_NAME/elf/ld*.so* $INSTALL/lib
    cp $ROOT/$PKG_BUILD/.$TARGET_NAME/libc.so.6 $INSTALL/lib
    cp $ROOT/$PKG_BUILD/.$TARGET_NAME/math/libm.so.6 $INSTALL/lib
    cp $ROOT/$PKG_BUILD/.$TARGET_NAME/nptl/libpthread.so.0 $INSTALL/lib

    if [ "$TARGET_ARCH" = "arm" -a "$TARGET_FLOAT" = "hard" ]; then
      ln -sf ld.so $INSTALL/lib/ld-linux.so.3
    fi
}
