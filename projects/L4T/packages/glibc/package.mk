PKG_NAME="glibc"
PKG_VERSION="2.27"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/libc/"
PKG_URL="http://ftp.gnu.org/pub/gnu/glibc/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="ccache:host autotools:host autoconf:host linux:host gcc:bootstrap"
PKG_DEPENDS_INIT="glibc"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="glibc: The GNU C library"
PKG_LONGDESC="The Glibc package contains the main C library. This library provides the basic routines for allocating memory, searching directories, opening and closing files, reading and writing files, string handling, pattern matching, arithmetic, and so on."
PKG_BUILD_FLAGS="-gold -lto"

PKG_CONFIGURE_OPTS_TARGET="BASH_SHELL=/bin/sh \
                           ac_cv_path_PERL=no \
                           ac_cv_prog_MAKEINFO= \
                           --libexecdir=/usr/lib/glibc \
                           --cache-file=config.cache \
                           --disable-profile \
                           --disable-sanity-checks \
                           --enable-add-ons \
                           --enable-bind-now \
                           --with-elf \
                           --with-tls \
                           --with-__thread \
                           --with-binutils=${BUILD}/toolchain/bin \
                           --with-headers=${SYSROOT_PREFIX}/usr/include \
                           --enable-kernel=3.0.0 \
                           --without-cvs \
                           --without-gd \
                           --disable-obsolete-rpc \
                           --disable-build-nscd \
                           --disable-nscd \
                           --enable-lock-elision \
                           --disable-timezone-tools"

if [ "${DEBUG}" = yes ]; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-debug"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-debug"
fi

NSS_CONF_DIR="${PKG_BUILD}/nss"

GLIBC_EXCLUDE_BIN="catchsegv gencat getconf iconv iconvconfig"
GLIBC_EXCLUDE_BIN+=" makedb mtrace pcprofiledump"
GLIBC_EXCLUDE_BIN+=" pldd rpcgen sln sotruss sprof xtrace"

pre_build_target() {
  cd "${PKG_BUILD}"
    aclocal --force --verbose
    autoconf --force --verbose
  cd -
}

pre_configure_target() {
# Filter out some problematic *FLAGS
  CFLAGS=${CFLAGS//-ffast-math/}
  CFLAGS=${CFLAGS//-Ofast/-O2}
  CFLAGS=${CFLAGS//-O./-O2}
  CFLAGS=${CFLAGS//-Werror/}
  CFLAGS=${CFLAGS//-mthumb/}


  if [ -n "${PROJECT_CFLAGS}" ]; then
    CFLAGS=${CFLAGS//${PROJECT_CFLAGS}/}
  fi

  LDFLAGS=${LDFLAGS//-ffast-math/}
  LDFLAGS=${LDFLAGS//-Ofast/-O2}
  LDFLAGS=${LDFLAGS//-O./-O2}
  LDFLAGS=${LDFLAGS//-Wl,--as-needed/}
  export LDFLAGS=${LDFLAGS//-Werror/}

  unset LD_LIBRARY_PATH

  # set some CFLAGS we need
  export CFLAGS="${CFLAGS} -g -fno-stack-protector -Wno-error -Wmissing-attributes"

  export BUILD_CC="${HOST_CC}"
  export OBJDUMP_FOR_HOST=objdump

cat >config.cache <<EOF
libc_cv_forced_unwind=yes
libc_cv_c_cleanup=yes11111
libc_cv_ssp=no
libc_cv_ssp_strong=no
libc_cv_slibdir=/usr/lib
EOF

echo "libdir=/usr/lib" >> configparms
echo "slibdir=/usr/lib" >> configparms
echo "sbindir=/usr/bin" >> configparms
echo "rootsbindir=/usr/bin" >> configparms
}

post_makeinstall_target() {
# we are linking against ld.so, so symlink
  ln -sf $(basename ${INSTALL}/usr/lib/ld-*.so) "${INSTALL}"/usr/lib/ld.so

# cleanup
  for i in "${GLIBC_EXCLUDE_BIN}"; do
    rm -rf "${INSTALL}"/usr/bin/$i
  done
  rm -rf "${INSTALL}"/usr/lib/audit
  rm -rf "${INSTALL}"/usr/lib/glibc
  rm -rf "${INSTALL}/"usr/lib/libc_pic
  rm -rf "${INSTALL}"/usr/lib/*.o
  rm -rf "${INSTALL}"/usr/lib/*.map
  rm -rf "${INSTALL}"/var

# remove locales and charmaps
  rm -rf "${INSTALL}"/usr/share/i18n/charmaps

# add UTF-8 charmap for Generic (charmap is needed for installer)
  if [ "${PROJECT}" = "Generic" ]; then
    mkdir -p "${INSTALL}"/usr/share/i18n/charmaps
    cp -PR "${PKG_BUILD}"/localedata/charmaps/UTF-8 "${INSTALL}"/usr/share/i18n/charmaps
    gzip "${INSTALL}"/usr/share/i18n/charmaps/UTF-8
  fi

  if [ ! "${GLIBC_LOCALES}" = yes ]; then
    rm -rf "${INSTALL}"/usr/share/i18n/locales

    mkdir -p "${INSTALL}"/usr/share/i18n/locales
      cp -PR "${PKG_BUILD}"/localedata/locales/POSIX "${INSTALL}"/usr/share/i18n/locales
  fi

# create default configs
  mkdir -p "${INSTALL}"/etc
    cp "${PKG_DIR}"/config/nsswitch-target.conf "${INSTALL}"/etc/nsswitch.conf
    cp "${PKG_DIR}"/config/host.conf "${INSTALL}"/etc
    cp "${PKG_DIR}"/config/gai.conf "${INSTALL}"/etc

  if [ "${TARGET_ARCH}" = "arm" -a "${TARGET_FLOAT}" = "hard" ]; then
    ln -sf ld.so "${INSTALL}"/usr/lib/ld-linux.so.3
  fi

  mkdir -p "${INSTALL}"/usr/sbin/
    ln -sf /usr/bin/ldconfig "${INSTALL}"/usr/sbin/ldconfig
}

configure_init() {
  cd "${PKG_BUILD}"
    rm -rf "${PKG_BUILD}"/."${TARGET_NAME}"-init
}

make_init() {
  : # reuse make_target()
}

makeinstall_init() {
  mkdir -p "${INSTALL}"/usr/lib
    cp -PR "${PKG_BUILD}"/."${TARGET_NAME}"/elf/ld*.so* "${INSTALL}"/usr/lib
    cp -PR "${PKG_BUILD}"/."${TARGET_NAME}"/libc.so* "${INSTALL}"/usr/lib
    cp -PR "${PKG_BUILD}"/."${TARGET_NAME}"/math/libm.so* "${INSTALL}"/usr/lib
    cp -PR "${PKG_BUILD}"/."${TARGET_NAME}"/nptl/libpthread.so* "${INSTALL}"/usr/lib
    cp -PR "${PKG_BUILD}"/."${TARGET_NAME}"/rt/librt.so* "${INSTALL}"/usr/lib
    cp -PR "${PKG_BUILD}"/."${TARGET_NAME}"/resolv/libnss_dns.so* "${INSTALL}"/usr/lib
    cp -PR "${PKG_BUILD}"/."${TARGET_NAME}"/resolv/libresolv.so* "${INSTALL}"/usr/lib

    if [ "${TARGET_ARCH}" = "arm" -a "${TARGET_FLOAT}" = "hard" ]; then
      ln -sf ld.so "${INSTALL}"/usr/lib/ld-linux.so.3
    fi
}

post_makeinstall_init() {
# create default configs
  mkdir -p "${INSTALL}"/etc
    cp "${PKG_DIR}"/config/nsswitch-init.conf "${INSTALL}"/etc/nsswitch.conf
}
