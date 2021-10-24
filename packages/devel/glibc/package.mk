# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glibc"
PKG_VERSION="2.32"
PKG_SHA256="1627ea54f5a1a8467032563393e0901077626dc66f37f10ee6363bb722222836"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/libc/"
PKG_URL="http://ftp.gnu.org/pub/gnu/glibc/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="ccache:host autotools:host linux:host gcc:bootstrap pigz:host Python3:host"
PKG_DEPENDS_INIT="glibc"
PKG_LONGDESC="The Glibc package contains the main C library."
PKG_BUILD_FLAGS="-gold"

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
                           --enable-kernel=5.4.0 \
                           --without-cvs \
                           --without-gd \
                           --disable-build-nscd \
                           --disable-nscd \
                           --enable-lock-elision \
                           --disable-timezone-tools"

if [ "${PROJECT}" = "L4T" ]; then
  PKG_CONFIGURE_OPTS_TARGET="${PKG_CONFIGURE_OPTS_TARGET//--enable-kernel=5.4.0/--enable-kernel=3.0.0/}"
fi

if build_with_debug; then
  PKG_CONFIGURE_OPTS_TARGET+=" --enable-debug"
else
  PKG_CONFIGURE_OPTS_TARGET+=" --disable-debug"
fi

post_unpack() {
  find "${PKG_BUILD}" -type f -name '*.py' -exec sed -e '1s,^#![[:space:]]*/usr/bin/python.*,#!/usr/bin/env python3,' -i {} \;
}

pre_build_target() {
  cd ${PKG_BUILD}
    aclocal --force --verbose
    autoconf --force --verbose
  cd -
}

pre_configure_target() {
# Filter out some problematic *FLAGS
  export CFLAGS=$(echo ${CFLAGS} | sed -e "s|-ffast-math||g")
  export CFLAGS=$(echo ${CFLAGS} | sed -e "s|-Ofast|-O2|g")
  export CFLAGS=$(echo ${CFLAGS} | sed -e "s|-O.|-O2|g")

  if [ -n "${PROJECT_CFLAGS}" ]; then
    export CFLAGS=$(echo ${CFLAGS} | sed -e "s|${PROJECT_CFLAGS}||g")
  fi

  export LDFLAGS=$(echo ${LDFLAGS} | sed -e "s|-ffast-math||g")
  export LDFLAGS=$(echo ${LDFLAGS} | sed -e "s|-Ofast|-O2|g")
  export LDFLAGS=$(echo ${LDFLAGS} | sed -e "s|-O.|-O2|g")

  export LDFLAGS=$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||")

  unset LD_LIBRARY_PATH

  # set some CFLAGS we need
  export CFLAGS="${CFLAGS} -g -fno-stack-protector"

  export BUILD_CC=${HOST_CC}
  export OBJDUMP_FOR_HOST=objdump

  cat >config.cache <<EOF
libc_cv_forced_unwind=yes
libc_cv_c_cleanup=yes
libc_cv_ssp=no
libc_cv_ssp_strong=no
libc_cv_slibdir=/usr/lib
EOF

  cat >configparms <<EOF
libdir=/usr/lib
slibdir=/usr/lib
sbindir=/usr/bin
rootsbindir=/usr/bin
build-programs=yes
EOF

  # binaries to install into target
  GLIBC_INCLUDE_BIN="getent ldd locale localedef"
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/.noinstall
    cp -p ${INSTALL}/usr/bin/localedef ${INSTALL}/.noinstall
    cp -a ${INSTALL}/usr/share/i18n/locales ${INSTALL}/.noinstall
    mv ${INSTALL}/usr/share/i18n/charmaps ${INSTALL}/.noinstall

  # Generic "installer" needs localedef to define drawing chars
  if [ "${PROJECT}" != "Generic" ]; then
    rm ${INSTALL}/usr/bin/localedef
  fi

# we are linking against ld.so, so symlink
  ln -sf $(basename ${INSTALL}/usr/lib/ld-*.so) ${INSTALL}/usr/lib/ld.so

# cleanup
# remove any programs we don't want/need, keeping only those we want
  for f in $(find ${INSTALL}/usr/bin -type f); do
    listcontains "${GLIBC_INCLUDE_BIN}" "$(basename "${f}")" || safe_remove "${f}"
  done

  safe_remove ${INSTALL}/usr/lib/audit
  safe_remove ${INSTALL}/usr/lib/glibc
  safe_remove ${INSTALL}/usr/lib/libc_pic
  safe_remove ${INSTALL}/usr/lib/*.o
  safe_remove ${INSTALL}/usr/lib/*.map
  safe_remove ${INSTALL}/var

# add UTF-8 charmap for Generic (charmap is needed for installer)
  if [ "${PROJECT}" = "Generic" ]; then
    mkdir -p ${INSTALL}/usr/share/i18n/charmaps
    cp -PR ${PKG_BUILD}/localedata/charmaps/UTF-8 ${INSTALL}/usr/share/i18n/charmaps
    pigz --best --force ${INSTALL}/usr/share/i18n/charmaps/UTF-8
  fi

  if [ ! "${GLIBC_LOCALES}" = yes ]; then
    safe_remove ${INSTALL}/usr/share/i18n/locales

    mkdir -p ${INSTALL}/usr/share/i18n/locales
      cp -PR ${PKG_BUILD}/localedata/locales/POSIX ${INSTALL}/usr/share/i18n/locales
  fi

# create default configs
  mkdir -p ${INSTALL}/etc
    cp ${PKG_DIR}/config/nsswitch-target.conf ${INSTALL}/etc/nsswitch.conf
    cp ${PKG_DIR}/config/host.conf ${INSTALL}/etc
    cp ${PKG_DIR}/config/gai.conf ${INSTALL}/etc

  if [ "${TARGET_ARCH}" = "arm" -a "${TARGET_FLOAT}" = "hard" ]; then
    ln -sf ld.so ${INSTALL}/usr/lib/ld-linux.so.3
  fi
}

configure_init() {
  cd ${PKG_BUILD}
    rm -rf ${PKG_BUILD}/.${TARGET_NAME}-init
}

make_init() {
  : # reuse make_target()
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/.${TARGET_NAME}/elf/ld*.so* ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/.${TARGET_NAME}/libc.so* ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/.${TARGET_NAME}/math/libm.so* ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/.${TARGET_NAME}/nptl/libpthread.so* ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/.${TARGET_NAME}/rt/librt.so* ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/.${TARGET_NAME}/resolv/libnss_dns.so* ${INSTALL}/usr/lib
    cp -PR ${PKG_BUILD}/.${TARGET_NAME}/resolv/libresolv.so* ${INSTALL}/usr/lib

    if [ "${TARGET_ARCH}" = "arm" -a "${TARGET_FLOAT}" = "hard" ]; then
      ln -sf ld.so ${INSTALL}/usr/lib/ld-linux.so.3
    fi
}

post_makeinstall_init() {
# create default configs
  mkdir -p ${INSTALL}/etc
    cp ${PKG_DIR}/config/nsswitch-init.conf ${INSTALL}/etc/nsswitch.conf
}
