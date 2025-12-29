# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="polkit"
PKG_VERSION="126"
PKG_SHA256="2814a7281989f6baa9e57bd33bbc5e148827e2721ccef22aaf28ab2b376068e8"
PKG_LICENSE="GPL"
PKG_SITE="https://polkit.pages.freedesktop.org/polkit"
PKG_URL="https://github.com/polkit-org/polkit/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="duktape"
PKG_DEPENDS_TARGET="toolchain expat glib systemd duktape"
PKG_LONGDESC="polkit provides an authorization API intended to be used by privileged programs offering service to unprivileged programs"

PKG_MESON_OPTS_TARGET="-Dauthfw=shadow \
                       -Dsession_tracking=logind \
                       -Dlibs-only=false \
                       -Dintrospection=false"
post_install() {
  add_user polkitd x 90 90 "polkit" "/" "/bin/false"
  add_group polkit 90

  enable_service polkit.service
  echo "chmod 04755 ${INSTALL}/usr/bin/pkexec" >> ${FAKEROOT_SCRIPT}
  echo "chomd 04755 ${INSTALL}/usr/lib/polkit-1/polkit-agent-helper-1" >> ${FAKEROOT_SCRIPT}
  echo "chown 0:90  ${INSTALL}/etc/polkit-1/rules.d" >> ${FAKEROOT_SCRIPT}
}
