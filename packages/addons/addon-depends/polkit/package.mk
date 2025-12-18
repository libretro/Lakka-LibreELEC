# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="polkit"
PKG_VERSION="127"
PKG_SHA256="9b7bc16f086479dcc626c575976568ba4a85d34297a750d8ab3d2e57f6d8b988"
PKG_LICENSE="GPL"
PKG_SITE="https://polkit.pages.freedesktop.org/polkit"
PKG_URL="https://github.com/polkit-org/polkit/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain expat glib systemd"
PKG_LONGDESC="polkit provides an authorization API intended to be used by privileged programs offering service to unprivileged programs"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dauthfw=shadow \
                       -Dsession_tracking=logind \
                       -Dlibs-only=true \
                       -Dintrospection=false"
